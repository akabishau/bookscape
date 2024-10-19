class CreateUserBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_books do |t|
      t.references :user, null: false, foreign_key: { on_delete: :restrict }
      t.references :book, null: false, foreign_key: { on_delete: :restrict }
      t.integer :status, null: false

      t.timestamps
    end

    # user has only one entry for each book
    add_index :user_books, [ :user_id, :book_id ], unique: true
  end
end
