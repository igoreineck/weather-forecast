class ForecastPresenter
  class AttributesMissing < StandardError; end

  def initialize(params: {})
    raise AttributesMissing if params.empty?

    @params = params
  end

  def to_h
    grouped_by_date
  end

  def list
    @params[:list]
  end

  def grouped_by_date
    grouped = @params[:list].group_by do |item|
      convert_time_with_time_zone(item[:dt]).strftime("%Y-%m-%d")
    end

    grouped.transform_values do |items|
      time_series = items.map do |i|
        i[:timezone] = @params.dig(:city, :timezone)

        WeatherPresenter.new(params: i).to_h
      end

      temp = time_series.map { |item| item[:temp] }
      {
        temp_min: temp.min,
        temp_max: temp.max,
        time_series:
      }
    end
  end

  private

  def convert_time_with_time_zone(dt)
    Time.at(dt + @params.dig(:city, :timezone)).utc
  end
end
