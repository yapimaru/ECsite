class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_index_path
    else
      @genres = Genre.all
      render :index
    end
  end
end
