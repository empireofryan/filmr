class ScriptsController < ApplicationController

  def index
    @scripts = Script.all
  end

  def new
    @script = Script.new
  end

  def show
    @script = Script.find(params[:id])
  end

  def create
    @script = Script.new(script_params)
    if @script.save
      flash[:success] = "Your event was successfully created!"
      redirect_to script_path(@script)
    else
      render :new
    end
  end

  private

  def script_params
    params.require(:script).permit(:title, :logline)
  end
end
