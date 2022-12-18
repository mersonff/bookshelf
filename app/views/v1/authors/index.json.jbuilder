# frozen_string_literal: true

json.authors do
  json.array! @loading_service.records, :id, :name
end

json.meta do
  json.partial! 'shared/pagination', pagination: @loading_service.pagination
end
