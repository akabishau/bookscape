class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :google_id

      t.timestamps
    end

    add_index :books, :google_id, unique: true
  end
end
