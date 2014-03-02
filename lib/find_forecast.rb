require_relative '../config/environment.rb'

class FindForecast
  def initialize(hour)
    @first_six = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    @next_eighteen = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US?pagenum=2&nextbeginIndex=6"))

    intro(hour)
    scrape_forecast(hour)
  end

  def intro(hour)
    introduction = "\nToday's date: #{Date.today}.\nThe weather for the next #{hour} hours is as follows:\n\n"
    puts introduction
  end

  def scrape_forecast(hour)
    scrape_six
    scrape_eighteen if hour == 24
  end

  def scrape_six
    to_delete = @first_six.css("span.wx-date-label").collect {|x| x.text} + @first_six.css("span.wx-day-label").collect {|x| x.text}
    forecasts = @first_six.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end
      puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")  if i % 4 == 0
    end
  end

  def scrape_eighteen
    to_delete = @next_eighteen.css("span.wx-date-label").collect {|x| x.text} + @next_eighteen.css("span.wx-day-label").collect {|x| x.text}
    forecasts = @next_eighteen.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end
      puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")
    end
  end
end