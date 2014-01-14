require "noaa-alerts/version"

module Noaa
  class Alert
    attr_reader :url
    
    def initialize(url, entry)
      @url = url
      @entry = entry
      @info = entry.fetch('info', {})
    end

    def method_missing(key)
      begin
        @info.fetch(key.to_s)
      rescue KeyError
        # to handle to_ary bug: see http://yehudakatz.com/2010/01/02/the-craziest-fing-bug-ive-ever-seen/
      end
    end

    def identifier
      @entry.fetch('identifier')
    end

    def locations
      @info.fetch('area').fetch('areaDesc').split('; ')
    end

    def effective_at
      parsed_time_or_string('effective')
    end

    def expires_at
      parsed_time_or_string('expires')
    end

    def sent_at
      time = @entry.fetch('sent')
      Time.parse(time) rescue time
    end

    private
    
    def parsed_time_or_string(key)
      time = @info.fetch(key)
      Time.parse(time) rescue time
    end
  end
end
