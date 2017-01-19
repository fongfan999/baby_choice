class AddViewsToSpinaArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_articles, :views, :interger, default: 0
  end
end
