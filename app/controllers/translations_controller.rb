class TranslationsController < ApplicationController

  def index
    @translation = Translation.last
  end
  
  def new
  end
  
  def new2
  end
  
  def create
    source = translation_params
    result = Aitrans.new
    result = result.apitranslation(source)
    Translation.create(result)
    redirect_to action: :index
  end
  
  def create2
    source = translation_params
    source[:source_text] = Pic.last.ocr_text    #ここで文字をハッシュに追加
    result = Aitrans.new
    result = result.apitranslation(source)
    Translation.create(result)
    redirect_to action: :index  
  end
  
  private
  def translation_params
    params.permit(:source_text, :target_la)
  end
end
