# frozen_string_literal: true

json.author do
  json.extract! author, :id, :name, :writing_gender, :age, :created_at, :updated_at

  json.photo_url rails_blob_url(author.photo)
  json.books do
    json.array! author.books do |book|
      json.partial! 'v1/books/book', book: book
    end
  end
end
