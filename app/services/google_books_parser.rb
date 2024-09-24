class GoogleBooksParser
  def self.parse(json, _user)
    validate_json(json)

    json["items"].map do |item|
      data = ObjectAttributeMapping.create_data(item, ObjectAttributeMapping::GOOGLE_BOOKS_KEYS)

      # handle custom cases
      data[:edition_details] = {
        publisher: data[:publisher],
        published_date: data[:published_date],
        page_count: data[:page_count],
        isbn10: data[:identifiers]&.find { |id| id["type"] == "ISBN_10" }&.dig("identifier"),
        isbn13: data[:identifiers]&.find { |id| id["type"] == "ISBN_13" }&.dig("identifier"),
      }

      # TODO: review this way of handling special characters coming from Google API
      data[:description] = CGI.unescapeHTML(data[:description]) if data[:description]
      data[:short_description] = CGI.unescapeHTML(data[:short_description]) if data[:short_description]
      # Rails.logger.info("BOOK DATA: #{data}")
      data
    end
  end

  def self.validate_json(json)
    required_keys = ["kind", "totalItems", "items"]
    missing_keys = required_keys - json.keys

    raise "Invalid JSON: Missing keys #{missing_keys.join(", ")}" if missing_keys.any?

    item_required_keys = ["id", "volumeInfo", "selfLink"]
    json["items"].each do |item|
      item_missing_keys = item_required_keys - item.keys
      raise "Invalid JSON in items: Missing keys #{item_missing_keys.join(", ")}" if item_missing_keys.any?
    end
  end

  def self.parse_single_book(json_response)
    # Extract the volumeInfo from the JSON response
    Rails.logger.info("Parsing single book: #{json_response}")
    volume_info = json_response["volumeInfo"]

    {
      title: volume_info["title"],
      google_id: json_response["id"],
      authors: volume_info["authors"] || [],
      main_category: volume_info["categories"]&.first, # Assuming you want the first category as the main category
      description: volume_info["description"],
      cover_url_thumbnail: volume_info.dig("imageLinks", "thumbnail"),
      short_description: volume_info["subtitle"], # Subtitle can be treated as a short description if necessary
      subtitle: volume_info["subtitle"],
      publisher: volume_info["publisher"],
      published_date: volume_info["publishedDate"],
      isbn13: volume_info["industryIdentifiers"]&.find { |id| id["type"] == "ISBN_13" }&.dig("identifier"),
      isbn10: volume_info["industryIdentifiers"]&.find { |id| id["type"] == "ISBN_10" }&.dig("identifier"),
      page_count: volume_info["pageCount"],
      print_type: volume_info["printType"],
      self_link: json_response["selfLink"],
      categories: volume_info["categories"] || [],
    }
  end

  private_class_method :validate_json
end
