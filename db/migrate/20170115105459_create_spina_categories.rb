class CreateSpinaCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_categories do |t|
      t.string :name
    end
  end
end
