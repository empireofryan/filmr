class GenresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @genres = Genre.all
  end

  def new
    @genre = current_user.genres.build
  end

  def create
    @genre = current_user.scripts.build(genre_params)
    if @genre.save
      flash[:success] = "Your event was successfully created!"
      redirect_to genre_path(@genre)
    else
      render :new
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:type)
  end
end
