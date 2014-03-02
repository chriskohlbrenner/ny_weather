Gem::Specification.new do |s|
  s.name        = 'ny_forecast'
  s.version     = '0.0.5'
  s.executables << 'ny_forecast'
  s.date        = '2014-03-02'
  s.summary     = "NY weather forecast"
  s.description = "Gathers 6-hour, 24-hour, and 5-day weather forecasts for NYC from weather.com"
  s.authors     = ["Chris Kohlbrenner"]
  s.email       = 'chris.kohlbrenner@gmail.com'
  s.files       = ["lib/find_forecast.rb", "lib/runner.rb", "bin/ny_forecast", "config/environment.rb"]
  s.homepage    = 'http://rubygems.org/gems/ny_forecast'
  s.license     = 'MIT'
  s.add_runtime_dependency "nokogiri", [">= 0"]
end