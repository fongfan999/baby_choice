class AddSlugToSpinaCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_categories, :slug, :string
  end
end
