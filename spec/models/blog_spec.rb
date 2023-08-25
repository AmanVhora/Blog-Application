require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { create(:user) }
  before do
    @blog = Blog.new(
      title: Faker::Lorem.paragraph(sentence_count: 1),
      description: Faker::Lorem.paragraph(sentence_count: 5),
      cover_image: Rack::Test::UploadedFile.new( Rails.root.join('public/cover-photo.png'), 'image/png'),
      user_id: user.id
    )
  end

  describe 'Valid Blog' do
    it{ expect(@blog).to be_valid }
  end

  describe 'Invalid Blog' do
    context "Title validation" do
      it 'blog invalid if title not present' do
        @blog.title = nil
        expect(@blog).to_not be_valid
      end

      it 'blog invalid if title length is greater than 100' do
        @blog.title = "a"*101
        expect(@blog).to_not be_valid
      end
    end

    it 'blog invalid if description not present' do
      @blog.description = nil
      expect(@blog).to_not be_valid
    end

    it 'blog invalid if cover image not present' do
      @blog.cover_image = nil
      expect(@blog).to_not be_valid
    end

    it 'blog invalid if user not present' do
      @blog.user_id = nil
      expect(@blog).to_not be_valid
    end
  end
end
