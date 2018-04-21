class TranslationsController < ApplicationController

    def index
        @translation = Translation.last
    end
    
    def new
    end
    
    def create
        source = translation_params
        result = Aitrans.new
        result = result.apitranslation(source)
        
        @source_text = result[:source_text]
        @target_la = result[:target_la]
        @google_tra = result[:google_tra]
        @azure_tra = result[:azure_tra]
        
    end
    
    private
    def translation_params
        params.permit(:source_text, :target_la)
    end
end
