# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Name.name }
    writing_gender { :fiction }
    age { Faker::Number.between(from: 1, to: 100) }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/product_image.png'), 'image/png') }

    trait :with_books do
      after(:create) do |author|
        create_list(:book, 3, author: author)
      end
    end
  end
end
