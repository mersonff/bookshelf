# frozen_string_literal: true

module V1
  class AuthorsController < ApiController
    before_action :set_author, only: %i[show update destroy]

    # GET /authors
    # GET /authors.json
    def index
      @authors = Author.all
    end

    # GET /authors/1
    # GET /authors/1.json
    def show; end

    # POST /authors
    # POST /authors.json
    def create
      @author = Author.new(author_params)

      if @author.save
        render :show, status: :ok
      else
        render_error(fields: @author.errors.messages)
      end
    end

    # PATCH/PUT /authors/1
    # PATCH/PUT /authors/1.json
    def update
      if @author.update(author_params)
        render :show, status: :ok
      else
        render_error(fields: @author.errors.messages)
      end
    end

    # DELETE /authors/1
    # DELETE /authors/1.json
    def destroy
      return if @author.destroy

      render_error(fields: @author.errors.messages)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name, :writing_gender, :age, :photo)
    end
  end
end
