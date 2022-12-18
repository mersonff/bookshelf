# frozen_string_literal: true

class Book < ApplicationRecord
  include LikeSearchable
  include Paginatable
  include Genderable

  belongs_to :author
  has_one_attached :image

  validates :description, presence: true, length: { minimum: 3 }
  validates :publisher, presence: true, length: { minimum: 3 }
  validates :publication_date, presence: true
  validates :image, presence: true
  validates :writing_gender, presence: true
end
