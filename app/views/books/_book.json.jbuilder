json.extract! book, :id, :isbn_code, :title, :price, :publish, :published, :dl, :created_at, :updated_at
json.url book_url(book, format: :json)
