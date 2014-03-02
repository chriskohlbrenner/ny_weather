require 'nokogiri'
require 'open-uri'

class NYForecast
  def initialize
    @doc = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    scrape_forecast
  end


  def scrape_forecast
    
    
    forecasts = @doc.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    forecasts.each_with_index do |forecast, i|
      if i % 4 == 0
        puts forecast.gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")
      end
    end

    
  end

end