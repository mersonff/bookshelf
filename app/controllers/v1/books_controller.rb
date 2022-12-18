# frozen_string_literal: true

module V1
  class BooksController < ApiController
    before_action :set_book, only: %i[show update destroy]

    # GET /books
    # GET /books.json
    def index
      @loading_service = ModelLoadingService.new(Book.all, searchable_params)
      @loading_service.call
    end

    # GET /books/1
    # GET /books/1.json
    def show; end

    # POST /books
    # POST /books.json
    def create
      @book = Book.new(book_params)

      if @book.save
        render :show, status: :ok
      else
        render_error(fields: @book.errors.messages)
      end
    end

    # PATCH/PUT /books/1
    # PATCH/PUT /books/1.json
    def update
      if @book.update(book_params)
        render :show, status: :ok
      else
        render_error(fields: @book.errors.messages)
      end
    end

    # DELETE /books/1
    # DELETE /books/1.json
    def destroy
      return if @book.destroy

      render_error(fields: @book.errors.messages)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:description, :author_id, :image, :writing_gender, :publication_date, :publisher)
    end

    def searchable_params
      params.permit({ search: :description }, { order: {} }, :page, :length)
    end
  end
end
