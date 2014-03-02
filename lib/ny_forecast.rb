require 'nokogiri'
require 'open-uri'
require 'pry'

class NYForecast
  def initialize
    @doc = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    scrape_forecast
  end


  def scrape_forecast
    to_delete = @doc.css("span.wx-date-label").collect {|x| x.text} + @doc.css("span.wx-day-label").collect {|x| x.text}

    forecasts = @doc.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end
    
      if i % 4 == 0
        puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")
      end
    end

    
  end

end

NYForecast.new

# .gsub(/"#{@doc.css("span.wx-date-label").text}"{3}/,"")