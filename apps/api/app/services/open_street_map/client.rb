module OpenStreetMap
  class Client
    API_KEY = ENV["OPEN_CAGE_API_KEY"]

    def initialize
      @instance = OpenCage::Geocoder.new(api_key: API_KEY)
    end

    def search_by(address:)
      return if address.empty?

      @instance.geocode(address)
    end
  end
end

# Example of response:
# {"annotations" =>
#      {"DMS" => {"lat" => "26° 18' 12.22272'' S", "lng" => "48° 51' 22.55148'' W"},
#       "MGRS" => "22JGR1401688941",
#       "Maidenhead" => "GG53nq77fe",
#       "Mercator" => {"x" => -5438654.464, "y" => -3017777.848},
#       "OSM" =>
#        {"edit_url" => "https://www.openstreetmap.org/edit?node=4564385664#map=17/-26.30340/-48.85626",
#         "note_url" => "https://www.openstreetmap.org/note/new#map=17/-26.30340/-48.85626&layers=N",
#         "url" => "https://www.openstreetmap.org/?mlat=-26.30340&mlon=-48.85626#map=17/-26.30340/-48.85626"},
#       "UN_M49" => {"regions" => {"AMERICAS" => "019", "BR" => "076", "LATIN_AMERICA" => "419", "SOUTH_AMERICA" => "005", "WORLD" => "001"}, "statistical_groupings" => ["LEDC"]},
#       "callingcode" => 55,
#       "currency" =>
#        {"decimal_mark" => ",",
#         "html_entity" => "R$",
#         "iso_code" => "BRL",
#         "iso_numeric" => "986",
#         "name" => "Brazilian Real",
#         "smallest_denomination" => 5,
#         "subunit" => "Centavo",
#         "subunit_to_unit" => 100,
#         "symbol" => "R$",
#         "symbol_first" => 1,
#         "thousands_separator" => "."},
#       "flag" => "🇧🇷",
#       "geohash" => "6gm625xgwe8zvsw93hvk",
#       "qibla" => 70.1,
#       "roadinfo" => {"drive_on" => "right", "road" => "Rua João Theis", "speed_in" => "km/h"},
#       "sun" =>
#        {"rise" => {"apparent" => 1793435220, "astronomical" => 1793430240, "civil" => 1793433720, "nautical" => 1793432040},
#         "set" => {"apparent" => 1793482320, "astronomical" => 1793487240, "civil" => 1793483760, "nautical" => 1793485500}},
#       "timezone" => {"name" => "America/Sao_Paulo", "now_in_dst" => 0, "offset_sec" => -10800, "offset_string" => "-0300", "short_name" => "BRT"},
#       "what3words" => {"words" => "ridge.tickles.pointer"}},
#     "bounds" => {"northeast" => {"lat" => -26.3033452, "lng" => -48.8562143}, "southwest" => {"lat" => -26.3034452, "lng" => -48.8563143}},
#     "components" =>
#      {"ISO_3166-1_alpha-2" => "BR",
#       "ISO_3166-1_alpha-3" => "BRA",
#       "ISO_3166-2" => ["BR-SC"],
#       "_category" => "building",
#       "_normalized_city" => "Joinville",
#       "_type" => "building",
#       "city" => "Joinville",
#       "continent" => "South America",
#       "country" => "Brazil",
#       "country_code" => "br",
#       "house_number" => "110",
#       "partial_postcode" => 89201,
#       "region" => "South Region",
#       "road" => "Rua João Theis",
#       "state" => "Santa Catarina",
#       "state_code" => "SC",
#       "suburb" => "Atiradores"},
#     "confidence" => 10,
#     "formatted" => "Rua João Theis, 110, Atiradores, Joinville - SC, 89201, Brazil",
#     "geometry" => {"lat" => -26.3033952, "lng" => -48.8562643}}>
