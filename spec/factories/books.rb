FactoryBot.define do
  factory :book do
    description { Faker::Book.title }
    writing_gender { :fiction }
    publication_date { Faker::Date.backward }
    publisher { Faker::Book.publisher }
    author
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/product_image.png'), 'image/png') }
  end
end
