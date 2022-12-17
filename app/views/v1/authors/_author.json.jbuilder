# frozen_string_literal: true

json.author do
  json.extract! author, :id, :name, :writing_gender, :age, :created_at, :updated_at
end
json.photo_url rails_blob_url(author.photo)
