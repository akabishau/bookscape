class AddShortDescriptionToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :short_description, :string
  end
end
