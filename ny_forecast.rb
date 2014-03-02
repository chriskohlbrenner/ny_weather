require 'pry'
require 'nokogiri'
require 'open-uri'

class NYForecast
  def initialize
    @doc = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    scrape_forecast
  end


  def scrape_forecast
    
    
    forecasts = @doc.css("div.wx-timepart").collect { |section| section.text }
    binding.pry

  end

  def scrape_hours
    
    
    new_array = @doc.css("div.wx-timepart h3.wx-time").text.split(/\n/).collect { |x| x[-5..-1] }.compact
    hours = new_array.collect {|string| string if (string.include?("AM") || string.include?("PM"))}.compact.collect { |string| string[-5] != "1" ? string[-4..-1] : string}
    hours.each do |hour|
      puts hour

    end
  end
end

NYForecast.new