# frozen_string_literal: true

json.authors do
  json.array! @authors, partial: 'v1/authors/author', as: :author
end
