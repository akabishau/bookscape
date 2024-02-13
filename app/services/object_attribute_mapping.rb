module ObjectAttributeMapping
  GOOGLE_BOOKS_KEYS = {
    google_id: "id",
    self_link: "selfLink",
    title: ["volumeInfo", "title"],
    subtitle: ["volumeInfo", "subtitle"],
    authors: ["volumeInfo", "authors"],
    main_category: ["volumeInfo", "categories"],
    categories: ["volumeInfo", "categories"],
    description: ["volumeInfo", "description"],
    short_description: ["searchInfo", "textSnippet"],
    cover_url_thumbnail: ["volumeInfo", "imageLinks", "thumbnail"],
    print_type: ["volumeInfo", "printType"],
    edition_details: {
      publisher: ["volumeInfo", "publisher"],
      published_date: ["volumeInfo", "publishedDate"],
      isbn13: ["volumeInfo", "industryIdentifiers", "ISBN_13", "identifier"],
      isbn10: ["volumeInfo", "industryIdentifiers", "ISBN_10", "identifier"],
      page_count: ["volumeInfo", "pageCount"]
    }
  }.freeze

  def self.create_data(item, keys)
    keys.transform_values do |path|
      path.is_a?(Array) ? item.dig(*path) : item[path]
    end
  end
end
