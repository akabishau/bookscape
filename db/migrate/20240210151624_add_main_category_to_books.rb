class AddMainCategoryToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :main_category, :string, array: true, default: []
  end
end
