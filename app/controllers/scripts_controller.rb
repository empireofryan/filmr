class ScriptsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @scripts = Script.where(genre_id: params[:genre_id])
  end

  def new
   # @script = Script.new
    @script = current_user.scripts.build
  end

  def show
    @script = Script.find(params[:id])
    @genre = Genre.find(params[:genre_id])
  end

  def create
    @script = current_user.scripts.build(script_params)
    if @script.save
      flash[:success] = "Your event was successfully created!"
      redirect_to script_path(@script)
    else
      render :new
    end
  end

  private

  def script_params
    params.require(:script).permit(:title, :logline, :genre_id)
  end
end
