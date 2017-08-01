class HelloController < ApplicationController
  def index
    render plain: 'hello world'
  end

  def view
    @msg = 'hello world'
  end

  def list
    @books = Book.all
  end
end
