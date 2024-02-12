class AddDetailsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :subtitle, :string
    add_column :books, :publisher, :string
    add_column :books, :published_date, :date
    add_column :books, :isbn_13, :string
    add_column :books, :isbn_10, :string
    add_column :books, :page_count, :integer
    add_column :books, :print_type, :string
    add_column :books, :self_link, :string
    add_column :books, :categories, :text, array: true, default: []
  end
end
