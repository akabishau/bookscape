## Description

This project is the final assignment for my Ruby on Rails class with [Code the Dream](https://codethedream.org/about/), a non-profit organization that provides tech education to people from diverse backgrounds.

The goal of this project is to apply the concepts and skills learned throughout [Ruby on Rails course curriculum](https://learn.codethedream.org/firefish-ruby-rails/). Throughout the development process, I've incorporated a range of Ruby on Rails concepts and technologies, including MVC architecture, DRY priciple, database migrations, and unit testing.

### What's This App For?
Bookscape is a web-based application designed to help users discover, track, and interact with books they're interested in. Leveraging the Google Books API, it allows users to:

- **Search for Books**: Users can find books based on titles, authors, or genres, accessing a vast database of literary works.
- **View Book Details**: For each book, users can view comprehensive information, including title, author, description, and cover image, to make informed decisions about their reading choices.
- **Track Reading Progress**: Users can maintain a personal reading list, categorizing books into different statuses such as "Want to Read", "Currently Reading", and "Read".
- **Interact with Books** (currently under development): Upon marking a book as "Read", users can:
  - **Add Comments**: Users can share their thoughts and insights about the book, creating a community of discussions.
  - **Set Ratings**: Users can rate books on a predefined scale, contributing to a community-driven rating system.
  - **Answer Predefined Questions**: Users can respond to a set of questions about the book, designed to encourage deeper reflection and discussion on the content and themes.

## Local Development Environment Setup
To get started, clone the repository to your local machine, and run `bundle install` to install dependencies. Then, create and migrate the database with `rails db:create` and `rails db:migrate`. Finally, start the project with `rails server`.

### Database Setup
Bookscape uses PostgreSQL as its database. Before running the application, ensure you have PostgreSQL installed and running on your local system. If it's not installed, download and install it from the official [PostgreSQL website](https://www.postgresql.org/download/) or use a package manager. Here are macOS instructions:
- Install PostgreSQL: `brew install postgresql`
- Start the PostgreSQL Service: `brew services start postgresql`
- Access PostgreSQL: `psql postgres`
- Create a User with CREATEDB Role: `CREATE USER your_username WITH PASSWORD 'your_secure_password' CREATEDB;` (`\q` for exit PostgreSQL)
- Set Environment Variables in .env file:
```
BOOKSCAPE_DATABASE_USERNAME=your_username
BOOKSCAPE_DATABASE_PASSWORD=your_secure_password
```
- Navigate to the root directory of your Rails project and run: `bin/rails db:create db:migrate`
- This will create your development and test databases based on the configuration specified in config/database.yml and then migrate the database schema.

### API Setup
This application uses Google Books API. To run the application locally, you'll need to obtain your Google Books API key. Once you have this, add it to the .env file in the root of the project: `GOOGLE_BOOKS_API_KEY=your_google_books_api_key`



## Features

- **Book Browsing**: Users can browse through a list of books in the catalogue.
- **Book Details**: Users can view detailed information about a book, including its title, author, description, and cover image.
- **Google Books API Integration**: The application integrates with the Google Books API to fetch and display book data.
- **Data Validation**: The application validates the JSON data received from the Google Books API to ensure it contains all the required keys.
- **Unit Testing**: The application includes unit tests to verify the functionality of the code.


## Code Examples


## Technologies Used

- **Ruby on Rails**: The application is built using the Ruby on Rails web development framework.
- **Google Books API**: The application uses the Google Books API to fetch book data.
- **RSpec**: The application uses the RSpec testing framework for Ruby to write and run unit tests.
