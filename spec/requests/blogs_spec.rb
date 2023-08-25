require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:blog) { create_list(:blog, 1, user:) }
  before { sign_in user }

  let(:valid_blog) do
    {
      title: Faker::Lorem.paragraph(sentence_count: 1),
      description: Faker::Lorem.paragraph(sentence_count: 5),
      cover_image: Rack::Test::UploadedFile.new( Rails.root.join('public/cover-photo.png'), 'image/png'),
      user:
    }
  end

  let(:invalid_blog) do
    {
      name: Faker::Name.name,
      desc: Faker::Lorem.sentence
    }
  end

  describe 'GET /blogs' do
    it 'with user signed in should get index' do
      get blogs_path
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get index' do
      sign_out user
      get blogs_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /show' do
    it 'with user signed in should get show' do
      get blog_path(blog)
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get show' do
      sign_out user
      get blog_path(blog)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /new' do
    it 'with user signed in should get new' do
      get new_blog_path
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get new' do
      sign_out user
      get new_blog_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /edit' do
    it 'with user signed in should get edit' do
      get edit_blog_path(blog)
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get edit' do
      sign_out user
      get edit_blog_path(blog)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST /create' do
    context 'with user signed in' do
      it 'with valid parameters should create blog' do
        expect do
          post blogs_path, params: { blog: valid_blog }
        end.to change { Blog.count }.by(1)
        expect(response).to redirect_to(blog_path(Blog.last))
      end

      it 'with invalid parameters should not create blog' do
        expect do
          post blogs_path, params: { blog: invalid_blog }
        end.to change { Blog.count }.by(0)
        expect(response).to have_http_status(422)
      end
    end

    context 'without user signed in' do
      it 'should not create blog' do
        sign_out user
        expect do
          post blogs_path, params: { blog: valid_blog }
        end.to change { Blog.count }.by(0)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with user signed in' do
      it 'with valid parameters should update blog' do
        patch blog_path(blog), params: { blog: { title: 'Coding' } }
        expect(Blog.last.title).to eq('Coding')
        expect(response).to redirect_to(blog_path(blog))
      end

      it 'with invalid parameters should not update blog' do
        patch blog_path(blog), params: { blog: { name: 'Updated blog' } }
        expect(Blog.last.title).not_to eq('Updated blog')
      end
    end

    context 'without user signed in' do
      it 'should not update blog' do
        sign_out user
        patch blog_path(blog), params: { blog: { title: 'Updated blog' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'with user signed in should destroy blog' do
      blog = Blog.create valid_blog
      expect do
        delete blog_path(blog)
      end.to change { Blog.count }.by(-1)
      expect(response).to redirect_to(blogs_path)
    end

    it 'without user signed in should not destroy blog' do
      sign_out user
      blog = Blog.create valid_blog
      expect do
        delete blog_path(blog)
      end.to change { Blog.count }.by(0)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
