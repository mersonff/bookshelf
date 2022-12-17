# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author do
  subject(:author) { described_class.new }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:age) }
  it { is_expected.to validate_presence_of(:photo) }
  it { is_expected.to validate_presence_of(:writing_gender) }

  it { is_expected.to validate_length_of(:name).is_at_least(3) }
  it { is_expected.to validate_numericality_of(:age).only_integer }
  it { is_expected.to validate_numericality_of(:age).is_greater_than(0) }

  it {
    expect(author).to define_enum_for(:writing_gender).with_values(
      fiction: 0, fantasy: 1, non_fiction: 2, poetry: 3, biography: 4, autobiography: 5,
      romance: 6, science_fiction: 7, horror: 8, mystery: 9, thriller: 10, drama: 11
    )
  }
end
