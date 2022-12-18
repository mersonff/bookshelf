# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books' do
  let(:user) { create(:user) }

  describe 'GET /v1/books' do
    let(:books) { create_list(:book, 10) }

    before { books }

    it 'returns a list of books' do
      get v1_books_path, headers: auth_header(user)
      expect(body_json['books'].count).to eq 10
    end

    it 'returns success status' do
      get v1_books_path, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /books' do
    context 'with valid params' do
      let(:author) { create(:author) }
      let(:book_params) { { book: attributes_for(:book).merge({ author_id: author.id }) } }

      it 'adds a new book' do
        expect do
          post v1_books_path, headers: auth_header(user), params: book_params
        end.to change(Book, :count).by(1)
      end

      it 'returns last added book', :aggregate_failures do
        post v1_books_path, headers: auth_header(user), params: book_params
        expected_book = Book.last.as_json
        expect(body_json['book']['id']).to eq expected_book['id']
        expect(body_json['book']['description']).to eq expected_book['description']
      end

      it 'returns success status' do
        post v1_books_path, headers: auth_header(user), params: book_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:book_invalid_params) do
        { book: attributes_for(:book, description: nil) }.to_json
      end

      it 'does not add a new book' do
        expect do
          post v1_books_path, headers: auth_header(user), params: book_invalid_params
        end.not_to change(Book, :count)
      end

      it 'returns error message' do
        post v1_books_path, headers: auth_header(user), params: book_invalid_params
        expect(body_json['errors']['fields']).to have_key('description')
      end

      it 'returns unprocessable_entity status' do
        post v1_books_path, headers: auth_header(user), params: book_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /books/:id' do
    let(:book) { create(:book) }

    context 'with valid params' do
      let(:new_description) { 'My new book' }
      let(:book_params) { { book: { description: new_description } }.to_json }

      it 'updates book' do
        patch v1_book_path(book), headers: auth_header(user), params: book_params
        book.reload
        expect(book.description).to eq new_description
      end

      it 'returns updated book', :aggregate_failures do
        patch v1_book_path(book), headers: auth_header(user), params: book_params
        book.reload
        expected_book = book.as_json
        expect(body_json['book']['id']).to eq expected_book['id']
        expect(body_json['book']['description']).to eq new_description
      end

      it 'returns success status' do
        patch v1_book_path(book), headers: auth_header(user), params: book_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:book_invalid_params) do
        { book: attributes_for(:book, description: nil) }.to_json
      end

      it 'does not update book' do
        old_description = book.description
        patch v1_book_path(book), headers: auth_header(user), params: book_invalid_params
        book.reload
        expect(book.description).to eq old_description
      end

      it 'returns error message' do
        patch v1_book_path(book), headers: auth_header(user), params: book_invalid_params
        expect(body_json['errors']['fields']).to have_key('description')
      end

      it 'returns unprocessable_entity status' do
        patch v1_book_path(book), headers: auth_header(user), params: book_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { create(:book) }

    it 'removes book' do
      expect do
        delete v1_book_path(book), headers: auth_header(user)
      end.to change(Book, :count).by(-1)
    end

    it 'returns success status' do
      delete v1_book_path(book), headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not return any body content' do
      delete v1_book_path(book), headers: auth_header(user)
      expect(body_json).not_to be_present
    end
  end
end
