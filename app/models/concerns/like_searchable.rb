# frozen_string_literal: true

module LikeSearchable
  extend ActiveSupport::Concern

  included do
    scope :like, lambda { |key, value|
      where(arel_table[key].matches("%#{value}%"))
    }
  end
end
