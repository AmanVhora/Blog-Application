FactoryBot.define do
  factory(:blog) do
    title { Faker::Lorem.paragraph(sentence_count: 1) }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    cover_image { Rack::Test::UploadedFile.new( Rails.root.join('public/cover-photo.png'), 'image/png') }
  end
end
