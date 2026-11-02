class WeatherPresenter
  def initialize(params: {})
    raise StandardError if params.empty? # @TODO: improve this message

    @params = params
  end

  def to_h
    {
      time: Time.at(@params[:dt] + @params[:timezone]).utc,
      temp:,
      weather_condition:
    }
  end

  def temp
    @params.dig(:main, :temp)
  end

  def weather_condition
    @params[:weather][0][:main]
  end
end
