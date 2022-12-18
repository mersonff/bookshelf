# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book do
  subject(:book) { described_class.new }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:publisher) }
  it { is_expected.to validate_presence_of(:publication_date) }
  it { is_expected.to validate_presence_of(:image) }
  it { is_expected.to validate_presence_of(:writing_gender) }
  
  it { is_expected.to belong_to(:author) }

  it { is_expected.to validate_length_of(:description).is_at_least(3) }
  it { is_expected.to validate_length_of(:publisher).is_at_least(3) }

  it {
    expect(book).to define_enum_for(:writing_gender).with_values(
      fiction: 0, fantasy: 1, non_fiction: 2, poetry: 3, biography: 4, autobiography: 5,
      romance: 6, science_fiction: 7, horror: 8, mystery: 9, thriller: 10, drama: 11
    )
  }

  it_has_behavior_of "like searchable concern", :book, :description
  it_behaves_like "paginatable concern", :book
end
