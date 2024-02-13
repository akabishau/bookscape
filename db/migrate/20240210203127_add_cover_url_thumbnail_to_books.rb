class AddCoverUrlThumbnailToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :cover_url_thumbnail, :string
  end
end
