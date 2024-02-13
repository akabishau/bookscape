require "rails_helper"

RSpec.describe BookService do
  describe ".find_or_create_book" do
    let(:book_params) do
      {
        google_id: "12345",
        title: "Test Book",
        authors: ["Test Author"],
        main_category: "Test Category",
        description: "Test Description",
        short_description: "Test Short Description",
        cover_url_thumbnail: "Test URL",
        print_type: "Test Print Type",
        subtitle: "Test Subtitle",
        edition_details: {
          publisher: "Test Publisher",
          published_date: Date.today,
          isbn13: "Test ISBN13",
          isbn10: "Test ISBN10",
          page_count: 100
        },
        self_link: "Test Self Link",
        categories: ["Test Category", "Another Test Category"]
      }
    end

    context "when the book does not exist" do
      it "creates a new book" do
        expect { BookService.find_or_create_book(book_params) }.to change { Book.count }.by(1)
      end
    end

    context "when the book already exists" do
      before do
        Book.create!(google_id: "12345", title: "Test Book", authors: ["Test Author"])
      end

      it "does not create a new book" do
        expect { BookService.find_or_create_book(book_params) }.to_not(change { Book.count })
      end

      it "returns the existing book" do
        existing_book = Book.find_by(google_id: "12345")
        expect(BookService.find_or_create_book(book_params)).to eq(existing_book)
      end
    end
  end
end
