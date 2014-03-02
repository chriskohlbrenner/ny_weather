Gem::Specification.new do |s|
  s.name        = 'ny_forecast'
  s.version     = '0.0.1'
  s.executables << 'ny_forecast'
  s.date        = '2014-03-01'
  s.summary     = "NY weather forecast"
  s.description = "Gathers next-6-hour weather forecast for NYC from weather.com"
  s.authors     = ["Chris Kohlbrenner"]
  s.email       = 'chris.kohlbrenner@gmail.com'
  s.files       = ["lib/ny_forecast.rb", "bin/ny_forecast"]
  s.homepage    = 'http://rubygems.org/gems/ny_forecast'
  s.license     = 'MIT'
  s.add_runtime_dependency "nokogiri", [">=0"]
end