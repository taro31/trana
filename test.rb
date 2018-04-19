require 'net/https'
require 'uri'
require 'json'
require 'cgi'

class Aitrans
  def initialize
    puts "ソース文章を入力してください。"
    @inputtext = gets.chomp
    puts "ターゲット言語を選択してください。\n英語：en 簡体字：zh-CN 繁体字：zh-TW 韓国語：ko 日本語：ja"
    @target = gets.chomp
  end
  
  def googletra
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
  end
  
  def azuretra
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
    
    alltra = response.body
    alllength = alltra.length           #全体の長さ
    tralength = alllength - 77          #訳文の長さ
    @azureresult = alltra.slice(68 , tralength)     #訳文だけ抽出
  end
  
  def result
    line = "------------------------------------------------------------------------------------"
    puts "#{line}"
    puts "googleの翻訳結果："
    puts "#{@googleresult}"
    puts "#{line}"
    puts "azureの翻訳結果："
    puts "#{@azureresult}"
    puts "#{line}"
  end
  
end

while true do
      # メニューの表示
  puts "[1]翻訳する"
  puts "[2]アプリを終了する"
  input = gets.to_i

  if input == 1
    translation = Aitrans.new
    translation.azuretra
    translation.googletra
    translation.result
  elsif input == 2
        exit
  else
        puts "入力された値は無効な値です。"
  end
end