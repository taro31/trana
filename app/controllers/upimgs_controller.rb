class UpimgsController < ApplicationController
  
  def index
  end
  
  def new
    @pic = Pic.new
  end
  
  def create
    Pic.create(image_params)
    
    #画像ダウンロード > base64化 > google cloud vision
    pic = Pic.last
    pic.ocr_text =  GoogleCloudVision.new.request
    pic.save
    redirect_to controller: :translations, action: :new2
  end
  
  private
  def image_params
    params.require(:pic).permit(:image)
  end
  
end
