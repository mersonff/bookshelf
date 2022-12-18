# frozen_string_literal: true

class Author < ApplicationRecord
  include LikeSearchable
  include Paginatable

  has_one_attached :photo

  enum writing_gender: {
    fiction: 0, fantasy: 1, non_fiction: 2, poetry: 3, biography: 4, autobiography: 5,
    romance: 6, science_fiction: 7, horror: 8, mystery: 9, thriller: 10, drama: 11
  }, _default: 0

  validates :name, presence: true, length: { minimum: 3 }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :photo, presence: true
  validates :writing_gender, presence: true
end
