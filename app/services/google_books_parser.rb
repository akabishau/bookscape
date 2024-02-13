class GoogleBooksParser
  require "object_attribute_mapping"

  def self.parse(json, _user)
    validate_json(json)

    json["items"].map do |item|
      ObjectAttributeMapping.create_data(item, ObjectAttributeMapping::GOOGLE_BOOKS_KEYS)
    end
  end

  def self.validate_json(json)
    required_keys = ["kind", "totalItems", "items"]
    missing_keys = required_keys - json.keys

    raise "Invalid JSON: Missing keys #{missing_keys.join(', ')}" if missing_keys.any?

    item_required_keys = ["id", "volumeInfo", "selfLink"]
    json["items"].each do |item|
      item_missing_keys = item_required_keys - item.keys
      raise "Invalid JSON in items: Missing keys #{item_missing_keys.join(', ')}" if item_missing_keys.any?
    end
  end

  private_class_method :validate_json
end
