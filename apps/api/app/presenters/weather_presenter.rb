class WeatherPresenter
  class AttributesMissing < StandardError; end

  def initialize(params: {})
    raise AttributesMissing if params.empty?

    @params = params
  end

  def to_h
    {
      time:,
      temp:,
      weather_condition:,
      weather_icon_url:
    }
  end

  def time
     Time.at(@params[:dt] + @params[:timezone]).utc
  end

  def temp
    @params.dig(:main, :temp)
  end

  def weather_condition
    @params[:weather][0][:main]
  end

  def weather_icon_url
    icon_id = @params[:weather][0][:icon]

    "https://openweathermap.org/img/wn/#{icon_id}@2x.png"
  end
end
