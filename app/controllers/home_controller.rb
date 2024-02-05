class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @quote = "\"If you don’t like to read, you haven’t found the right book.\""
    @author = "– J.K. Rowling"
  end
end
