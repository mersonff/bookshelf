# frozen_string_literal: true

json.books do
  json.array! @loading_service.records, :id, :description, :writing_gender, :publication_date, :publisher, :created_at,
    :updated_at
end

json.meta do
  json.partial! 'shared/pagination', pagination: @loading_service.pagination
end
