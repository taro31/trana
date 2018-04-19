#! ruby -Ku
require 'kconv'
#上記でazureの文字化け対策

require 'net/https'
require 'uri'
require 'json'
require 'cgi'

class Aitrans < ActiveRecord::Base

@inputtext = Translation.last.source_text
@target = Translation.last.target_la
#binding.pry

# googleのapi部分
    appid = ENV["GOOGLE_APP_ID"]
    url = URI.parse(URI.escape("https://translation.googleapis.com/language/translate/v2?key=#{appid}&target=#{@target}&q=#{@inputtext}"))
    res = Net::HTTP.start(url.host, url.port, use_ssl: true){|http|
        http.get(url.path + "?" + url.query);
    }
    
    hash = JSON.parse(res.body)         #JSONからハッシュの生成
    
    a = hash["data"]["translations"]    #ハッシュの精査
    hash2 = a[0]                        #なぜか配列が混ざってるので抽出
    @googleresult = hash2["translatedText"]        #翻訳文のみ抽出
#puts hash2["detectedSourceLanguage"]#ソース言語の抽出


# azureのapi部分
    key = ENV['AZURE_APP_ID']

    host = 'https://api.microsofttranslator.com'
    path = '/V2/Http.svc/Translate'
    
    params = '?to=' + @target + '&text=' + CGI.escape(@inputtext)
    uri = URI (host + path + params)
    
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = key
    
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request (request)
    end
    
    alltra = Kconv.toutf8(response.body)    #azureの文字化けエンコード指示
    
    alllength = alltra.length           #全体の長さ
    tralength = alllength - 77          #訳文の長さ
    @azureresult = alltra.slice(68 , tralength)     #訳文だけ抽出

    #データベース更新
    Translation.last.update(google_tra: @googleresult, azure_tra: @azureresult)

end
