class ChangeBooksColumnsNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :books, :title, false
    change_column_null :books, :google_id, false
    change_column_null :books, :authors, false
  end
end
