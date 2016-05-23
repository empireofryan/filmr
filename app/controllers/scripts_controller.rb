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
      redirect_to genre_scripts_path(@script.genre)
    else
      render :new
    end
  end

  def update
    @script = Script.find(params[:id])
    if @script.update(script_params)
      @script.save
      redirect_to genre_scripts_path(@script)
    else
      render :new
    end
  end

  def destroy
    @script = Script.find(params[:id])
    @script.destroy
    flash[:notice] = "Script deleted"
    redirect_to genre_scripts_path(@script.genre)
  end

  private

  def script_params
    params.require(:script).permit(:title, :logline, :genre_id, comments_attributes: [:description])
  end
  def genre_params
    params.require(:genre).permit(:genre_id)
  end
end
