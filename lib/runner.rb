require_relative '../config/environment.rb'
VALID = ["6 hours", "24 hours", "5 days"]

class Runner
  def interface
    on = true
    puts "======================================="
    puts "Welcome to NY Forecast"
    puts
    puts "You can view the 6-hour, 24-hour, or 5-day forecast. To view the forecasts,"
    puts "enter the specific amount of time in the following format: '6 hours', '24"
    puts "hours', or '5 days'."
    puts "(Type 'exit' to exit)"

    while on do
      @user_command = gets.chomp
      
      if VALID.include?(@user_command)
        FindForecast.new(@user_command)
        puts "Please enter your next request. Valid requests are '6 hours', '24 hours', "
        puts "'5 days', or 'exit'."
      elsif @user_command == "exit"
        exit
        on = false
      else
        puts "Invalid request! Please enter '6 hours', '24 hours', or '5 days' to view"
        puts "the forecasts."
      end
    end
  end

  def exit
    puts "Thank you for using NY Forecast."
  end
end