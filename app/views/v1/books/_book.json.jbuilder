# frozen_string_literal: true

json.book do
  json.extract! book, :id, :description, :writing_gender, :publication_date, :publisher, :created_at, :updated_at
end
json.image_url rails_blob_url(book.image)
