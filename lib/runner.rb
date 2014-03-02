require_relative '../config/environment.rb'

class Runner
  def interface
    on = true
    puts "======================================="
    puts "Welcome to NY Forecast"
    puts
    puts "You can view the hourly forecasts by entering '6' or '24' for 6-hour or 24-hour forecasts."
    puts "(Type 'exit' to exit)"

    while on do
      @user_command = gets.chomp
      
      if @user_command == '6'
        puts FindForecast.new(6)
        puts "Please enter your next request."
      elsif @user_command == '24'
        puts FindForecast.new(24)
        puts "Please enter your next request."
      elsif @user_command == "exit"
        exit
        on = false
      else
        puts "Invalid request! Please enter '6' or '24' to view the 6-hour or 24-hour forecasts."
      end
    end
  end

  def exit
    puts "Thanks for using NY Forecast"
  end
end