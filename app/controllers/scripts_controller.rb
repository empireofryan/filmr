class ScriptsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @scripts = Script.where(genre_id: params[:genre_id])
  end

  def new
    @script = current_user.scripts.build
    1.times { @script.comments.build }
  end

  def show
    @script = script_finder
    @genre = Genre.find(params[:genre_id])
  end

  def create
    @script = current_user.scripts.build(script_params)
    @script.comments do |comment|
      comment.user = current_user
      current_user.comments << comment
      comment.save
      binding.pry
      #does this comment have the user_id now?
    end
    binding.pry
    #to look at script, script.comments and see if all IDs are there
    if @script.save
      flash[:success] = "Your event was successfully created!"
      redirect_to genre_scripts_path(@script.genre)
    else
      render :new
      1.times { @script.comments.build }
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
    if Script.find(new)
      render :new_genre_script
    else
      Script.find(params[:id])
    end
  end

  def script_params
    params.require(:script).permit(:user_id, :title, :logline, :genre_id, comments_attributes: [:description, :user_id])
  end

  def genre_params
    params.require(:genre).permit(:genre_id)
  end

  def comment_params
   params.require(:script).permit(comments_attributes: [:description, :user_id])
  end
end
