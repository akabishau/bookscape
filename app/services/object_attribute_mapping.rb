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
    publisher: ["volumeInfo", "publisher"],
    published_date: ["volumeInfo", "publishedDate"],
    page_count: ["volumeInfo", "pageCount"],
    identifiers: ["volumeInfo", "industryIdentifiers"]
    # isbn13: ["volumeInfo", "industryIdentifiers", 1, "identifier"]
  }.freeze

  def self.create_data(item, keys)
    keys.transform_values do |path|
      if path.is_a?(Array)
        item.dig(*path)
      else
        item[path]
      end
    end
  end
end
