class TranslationsController < ApplicationController

    def index
        @translation = Translation.last
    end
    
    def new
    end
    
    def create
        Translation.create(translation_params)
        Aitrans
    end
    
    private
    def translation_params
        params.permit(:source_text, :target_la)
    end
end
