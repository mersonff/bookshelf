# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authors' do
  let(:user) { create(:user) }

  describe 'GET /v1/authors' do
    context 'with no books' do
      let(:authors) { create_list(:author, 10) }

      before { authors }

      it 'returns a list of authors' do
        get v1_authors_path, headers: auth_header(user)
        expect(body_json['authors'].count).to eq 10
      end

      it 'returns success status' do
        get v1_authors_path, headers: auth_header(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with books' do
      let(:authors) { create_list(:author, 10, :with_books) }

      before { authors }

      it 'returns a list of authors with books', :aggregate_failures do
        get v1_authors_path, headers: auth_header(user)
        expect(body_json['authors'].count).to eq 10
        expect(body_json['authors'].first['author']['books'].count).to eq 3
      end
    end
  end

  describe 'POST /authors' do
    context 'with valid params' do
      let(:author_params) { { author: attributes_for(:author) } }

      it 'adds a new author' do
        expect do
          post v1_authors_path, headers: auth_header(user), params: author_params
        end.to change(Author, :count).by(1)
      end

      it 'returns last added author', :aggregate_failures do
        post v1_authors_path, headers: auth_header(user), params: author_params
        expected_author = Author.last.as_json
        expect(body_json['author']['id']).to eq expected_author['id']
        expect(body_json['author']['name']).to eq expected_author['name']
      end

      it 'returns success status' do
        post v1_authors_path, headers: auth_header(user), params: author_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:author_invalid_params) do
        { author: attributes_for(:author, name: nil) }.to_json
      end

      it 'does not add a new author' do
        expect do
          post v1_authors_path, headers: auth_header(user), params: author_invalid_params
        end.not_to change(Author, :count)
      end

      it 'returns error message' do
        post v1_authors_path, headers: auth_header(user), params: author_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post v1_authors_path, headers: auth_header(user), params: author_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /authors/:id' do
    let(:author) { create(:author) }

    context 'with valid params' do
      let(:new_name) { 'My new author' }
      let(:author_params) { { author: { name: new_name } }.to_json }

      it 'updates author' do
        patch v1_author_path(author), headers: auth_header(user), params: author_params
        author.reload
        expect(author.name).to eq new_name
      end

      it 'returns updated author', :aggregate_failures do
        patch v1_author_path(author), headers: auth_header(user), params: author_params
        author.reload
        expected_author = author.as_json
        expect(body_json['author']['id']).to eq expected_author['id']
        expect(body_json['author']['name']).to eq new_name
      end

      it 'returns success status' do
        patch v1_author_path(author), headers: auth_header(user), params: author_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:author_invalid_params) do
        { author: attributes_for(:author, name: nil) }.to_json
      end

      it 'does not update author' do
        old_name = author.name
        patch v1_author_path(author), headers: auth_header(user), params: author_invalid_params
        author.reload
        expect(author.name).to eq old_name
      end

      it 'returns error message' do
        patch v1_author_path(author), headers: auth_header(user), params: author_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        patch v1_author_path(author), headers: auth_header(user), params: author_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /authors/:id' do
    let!(:author) { create(:author) }

    it 'removes author' do
      expect do
        delete v1_author_path(author), headers: auth_header(user)
      end.to change(Author, :count).by(-1)
    end

    it 'returns success status' do
      delete v1_author_path(author), headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not return any body content' do
      delete v1_author_path(author), headers: auth_header(user)
      expect(body_json).not_to be_present
    end
  end
end
