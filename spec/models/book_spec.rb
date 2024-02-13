require "rails_helper"

RSpec.describe Book, type: :model do
  # Validation tests
  it "is valid with valid attributes" do
    book = Book.new(title: "Test Book", google_id: "12345")
    expect(book).to be_valid
  end

  it "is not valid without a title" do
    book = Book.new(title: nil)
    expect(book).to_not be_valid
  end

  it "is not valid without a google_id" do
    book = Book.new(google_id: nil)
    expect(book).to_not be_valid
  end

  it "is not valid with a duplicate google_id" do
    Book.create!(title: "Test Book", google_id: "12345")
    book = Book.new(title: "Another Test Book", google_id: "12345")
    expect(book).to_not be_valid
  end
end
