module Spina
  class Category < ApplicationRecord
    has_and_belongs_to_many :articles, join_table: :articles_categories

    after_save :set_slug, if: :name_changed?

    def to_param
      slug
    end

    def to_uri
      "/categories/#{slug}"
    end

    def self.live
      sql = "SELECT category_id FROM articles_categories GROUP BY category_id"
      result = ActiveRecord::Base.connection.execute(sql)

      # Get array ids only
      category_ids = result.map { |c| c.first.last }
      # Return live categories
      where(id: category_ids)
    end

    private

    def set_slug
      self.update_columns(slug: name.delete_tonal.try(:parameterize))
    end
  end
end
