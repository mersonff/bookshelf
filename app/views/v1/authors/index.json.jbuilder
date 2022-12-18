# frozen_string_literal: true

json.authors do
  json.array! @loading_service.records, partial: 'v1/authors/author', as: :author
  # @loading_service.records.each do |author|
  #   json.partial! 'v1/authors/author', author: author
  # end
  # json.array! @loading_service.records, :id, :name, :writing_gender, :age, :created_at, :updated_at
end

json.meta do
  json.partial! 'shared/pagination', pagination: @loading_service.pagination
end
