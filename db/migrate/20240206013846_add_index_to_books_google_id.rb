class AddIndexToBooksGoogleId < ActiveRecord::Migration[7.0]
  def change
    add_index :books, :google_id, unique: true
  end
end
