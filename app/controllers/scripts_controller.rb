class ScriptsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @scripts = Script.where(genre_id: params[:genre_id])
  end

  def new
    @script = current_user.scripts.build
    1.times { @script.comments.build }
    if params["genre_id"].present?
      @genre_list = Genre.find([params["genre_id"]])
    else
      @genre_list = Genre.all
    end

  end

  def show
    @script = Script.find(params[:id])
    @genre = Genre.find(params[:genre_id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @script }
    end
  end

  def create
    @script = current_user.scripts.build(script_params)
    @script.comments do |comment|
      comment.user = current_user
      current_user.comments << comment
      comment.save

      #does this comment have the user_id now?
    end

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
    params.require(:script).permit(:user_id, :title, :logline, :genre_id, comments_attributes: [:description, :user_id])
  end

  def genre_params
    params.require(:genre).permit(:genre_id)
  end

  def comment_params
   params.require(:script).permit(comments_attributes: [:description, :user_id])
  end
end
