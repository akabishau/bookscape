class ChangeBooks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :books, :authors, from: nil, to: []
    rename_column :books, :isbn_13, :isbn13
    rename_column :books, :isbn_10, :isbn10
  end
end
