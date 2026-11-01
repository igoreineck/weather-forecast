class LocationBlueprint < Blueprinter::Base
  fields :display_name, :lat, :lon, :cached

  field :address do |location, _options|
    location[:address].slice(:state, :country, :country_code, :postcode)
  end

  def cached
    false
  end
end
