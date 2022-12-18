# frozen_string_literal: true

class Author < ApplicationRecord
  include LikeSearchable
  include Paginatable
  include Genderable

  has_one_attached :photo

  validates :name, presence: true, length: { minimum: 3 }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :photo, presence: true
  validates :writing_gender, presence: true
end
