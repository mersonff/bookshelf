# frozen_string_literal: true

require 'rails_helper'

describe ModelLoadingService do
  context 'when #call' do
    let!(:books) { create_list(:book, 15) }

    context 'when params are present' do
      let!(:search_books) do
        books = []
        15.times do |n|
          books << create(:book, description: "Search #{n + 1}", publisher: 'Merson')
        end
        books
      end

      let!(:unexpected_books) do
        books = []
        15.times do |n|
          books << create(:book, description: "Search #{n + 16}", publisher: 'João')
        end
        books
      end

      let(:params) do
        { search: { description: 'Search', publisher: 'Mers' }, order: { description: :desc }, page: 2, length: 4 }
      end

      it 'performs right :length following pagination' do
        service = described_class.new(Book.all, params)
        service.call
        expect(service.records.count).to eq 4
      end

      it 'do right search, order and pagination' do
        search_books.sort! { |a, b| b[:description] <=> a[:description] }
        service = described_class.new(Book.all, params)
        service.call
        expected_books = search_books[4..7]
        expect(service.records).to contain_exactly(*expected_books)
      end

      it 'sets right :page' do
        service = described_class.new(Book.all, params)
        service.call
        expect(service.pagination[:page]).to eq 2
      end

      it 'sets right :length' do
        service = described_class.new(Book.all, params)
        service.call
        expect(service.pagination[:length]).to eq 4
      end

      it 'sets right :total' do
        service = described_class.new(Book.all, params)
        service.call
        expect(service.pagination[:total]).to eq 15
      end

      it 'sets right :total_pages' do
        service = described_class.new(Book.all, params)
        service.call
        expect(service.pagination[:total_pages]).to eq 4
      end

      it 'does not return unenexpected records' do
        params.merge!(page: 1, length: 50)
        service = described_class.new(Book.all, params)
        service.call
        expect(service.records).not_to include(*unexpected_books)
      end
    end

    context 'when params are not present' do
      it 'returns default :length pagination' do
        service = described_class.new(Book.all, nil)
        service.call
        expect(service.records.count).to eq 10
      end

      it 'returns first 10 records' do
        service = described_class.new(Book.all, nil)
        service.call
        expected_books = books[0..9]
        expected_books_ids = expected_books.map(&:id)
        expect(service.records.pluck(:id)).to eq(expected_books_ids)
      end

      it 'sets right :page' do
        service = described_class.new(Book.all, nil)
        service.call
        expect(service.pagination[:page]).to eq 1
      end

      it 'sets right :length' do
        service = described_class.new(Book.all, nil)
        service.call
        expect(service.pagination[:length]).to eq 10
      end

      it 'sets right :total' do
        service = described_class.new(Book.all, nil)
        service.call
        expect(service.pagination[:total]).to eq 15
      end

      it 'sets right :total_pages' do
        service = described_class.new(Book.all, nil)
        service.call
        expect(service.pagination[:total_pages]).to eq 2
      end
    end
  end
end
