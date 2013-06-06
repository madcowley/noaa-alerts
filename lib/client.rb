require "alert"
require "httparty"

module Noaa
  class Client
    attr_reader :alerts

    def initialize(location)
      @alerts = []
      fetch_alerts_for(location)
    end

    private

    def fetch_alerts_for(location)
      if location.size == 2
        catalog = HTTParty.get("http://alerts.weather.gov/cap/#{location}.php?x=0", :format => :xml)
      elsif location.size == 6
        catalog = HTTParty.get("http://alerts.weather.gov/cap/wwaatmget.php?x=#{location}&y=1", :format => :xml)
      end
      handle_catalog(catalog)
    end

    def handle_catalog(catalog)
      entries = catalog['feed']['entry']
      entries = [entries] unless entries.kind_of?(Array)
      entries.each do |entry| 
        item = HTTParty.get(entry['id'], :format => :xml)['alert']
        if item
          alert = Noaa::Alert.new(entry['id'], item)
          @alerts << alert unless alert.description.empty?
        end
      end
    end
  end
end
