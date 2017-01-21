module Spina
  class Article < ActiveRecord::Base
    attr_accessor :old_materialized_path

    belongs_to :photo
    has_and_belongs_to_many :categories, join_table: :articles_categories

    validates :title, :body, :author, :publish_date, presence: true
    validates :slug, uniqueness: true

    before_validation :set_slug
    after_save :rewrite_rule,
      if: -> { old_materialized_path != materialized_path }

    scope :live, -> { where('publish_date <= ? AND draft = ?', Date.today, 0) }
    scope :newest_first, -> { live.order('publish_date DESC') }
    scope :most_visited, -> { live.order('views DESC').limit(5) }
    scope :search, -> (query) do
      if query.blank?
        newest_first
      else
        # Get query as tring arrar
        # Count appearance of frequency word
        # Sort array by frequency
        # Delete frequency number, get word only
        query_as_array = query
          .delete_tonal.split
          .each_with_object(Hash.new(0)) { |e,h| h[e] += 1 }
          .sort_by { |k, v| -v }
          .map(&:first)

        results = where("LOWER(body) LIKE ?", "%#{query.downcase}%")
        query_as_array.each do |word|
          results = results.or( search_by_slug(word) )
        end
        
        results
      end
    end

    self.per_page = 20

    def self.search_by_slug(query)
      # Match entire word
      where("slug LIKE ? OR slug LIKE ?", "#{query}-%", "%-#{query}-%")
    end

    def materialized_path
      "/articles/#{slug}"
    end

    def is_live?
      draft == 0
    end

    def increment!(by = 1)
      self.update_columns(views: views + by)
    end

    def next_article
      self.class.live.where("id > ?", id).order("id ASC").first
    end

    def prev_article
      self.class.live.where("id < ?", id).order("id DESC").first
    end

    private

    def set_slug
      self.old_materialized_path = materialized_path
      self.slug = "#{title.delete_tonal.try(:parameterize)}-#{id}"
      self.slug += "-#{self.class.where(slug: slug).count}" if self.class.where(slug: slug).where.not(id: id).count > 0
      slug
    end

    def rewrite_rule
      RewriteRule.create(old_path: old_materialized_path, new_path: materialized_path)
    end
  end
end
