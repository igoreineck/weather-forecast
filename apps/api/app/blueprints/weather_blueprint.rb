# // {
# // 	"coord": {
# // 		"lon": -48.8487,
# // 		"lat": -26.3045
# // 	},
# // 	"main": {
# // 		"temp": 24.59,
# // 		"feels_like": 25.25,
# // 		"temp_min": 23.96,
# // 		"temp_max": 24.59,
# // 	},
# // 	"dt": 1793465152,
#     "dt_txt": ...
# // }

# @TODO: evaluate how to better structure this output
class WeatherBlueprint < Blueprinter::Base
  fields :dt, :dt_txt

  # field :coord do |weather, _options|
  #   weather[:coord]&.slice(:lat, :lon)
  # end

  field :main do |weather, _options|
    weather[:main]&.slice(:temp, :feels_like, :temp_min, :temp_max)
  end

  def cached
    false
  end
end
