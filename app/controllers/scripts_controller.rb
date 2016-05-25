class ScriptsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @scripts = Script.where(genre_id: params[:genre_id])
  end

  def new
    @script = current_user.scripts.build

  end

  def show
    @script = script_finder
    @genre = Genre.find(params[:genre_id])
  end

  def create
    @script = current_user.scripts.build(script_params)
    @comment = current_user.comments.build(comment_params)
    
    if @script.save
      flash[:success] = "Your event was successfully created!"
      redirect_to genre_scripts_path(@script.genre)
    else
      render :new
    end
  end

  def update
    @script = script_finder
    if @script.update(script_params)
      @script.save
      redirect_to genre_scripts_path(@script)
    else
      render :new
    end
  end

  def destroy
    @script = script_finder
    @script.destroy
    flash[:notice] = "Script deleted"
    redirect_to genre_scripts_path(@script.genre)
  end

  private

  def script_finder
    Script.find(params[:id])
  end

  def script_params
    params.require(:script).permit(:title, :logline, :genre_id, comments_attributes: [:description, :user_id])
  end

  def genre_params
    params.require(:genre).permit(:genre_id)
  end

  def comment_params
#    params.require(:comment).permit(:description, :script_id, :user_id)
  end
end
