# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  MAX_PER_PAGE = 10
  DEFAULT_PAGE = 1

  included do
    scope :paginate, lambda { |page, length|
      page = DEFAULT_PAGE unless page.present? && page.positive?
      length = MAX_PER_PAGE unless length.present? && length.positive?
      starts_at = (page - 1) * length
      limit(length).offset(starts_at)
    }
  end
end
