require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"

get("/") do
  @http_response = HTTP.get("https://api.exchangerate.host/list",
    params: { access_key: ENV["EXCHANGE_RATE_KEY"] })
  @parsed = JSON.parse(@http_response.to_s)
  @currencies = @parsed.fetch("currencies").keys
  erb :home
end


get("/:from_ccy") do
  @from_ccy = params[:from_ccy]
  @http_response = HTTP.get("https://api.exchangerate.host/list",
    params: { access_key: ENV["EXCHANGE_RATE_KEY"] })
  @parsed = JSON.parse(@http_response.to_s)
  @currencies = @parsed.fetch("currencies").keys
  erb(:ccy_1)
end

get("/:from_ccy/:to_ccy") do
  @from_ccy = params[:from_ccy]
  @to_ccy = params[:to_ccy]
  @http_response = HTTP.get("https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@from_ccy}&to=#{@to_ccy}&amount=1")
  @parsed = JSON.parse(@http_response.to_s)
  @amount = @parsed.fetch("result")
  
  erb(:ccy_2)
end
