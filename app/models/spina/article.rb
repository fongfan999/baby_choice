module Spina
  class Article < ActiveRecord::Base
    attr_accessor :old_materialized_path

    belongs_to :photo

    validates :title, :body, :author, :publish_date, presence: true
    validates :slug, uniqueness: true

    before_validation :set_slug
    after_save :rewrite_rule,
      if: -> { old_materialized_path != materialized_path }

    scope :live, -> { where('publish_date <= ? AND draft = ?', Date.today, 0) }
    scope :newest_first, -> { order('publish_date DESC') }

    def materialized_path
      "/articles/#{slug}"
    end

    def is_live?
      draft == 0
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