class UpimgsController < ApplicationController
  
  def index
  end
  
  def new
    @pic = Pic.new
  end
  
  def create
    @pic = Pic.create(image_params)
  end
  
  private
  def image_params
    params.require(:pic).permit(:image)
  end
  
end
