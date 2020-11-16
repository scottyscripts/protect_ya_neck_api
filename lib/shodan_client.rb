require 'shodanz'
require 'singleton'

module HTTPClient
  class Shodan
    include Singleton

    def initialize
      @client = Shodanz.client.new(key: Rails.application.credentials.shodan[:api_key])
    end

    def ip_info(ip)
      res = @client.host(ip)

      format_ip_info_response(res)
    end

    def my_ip
      @client.my_ip
    end

    private
    
    def format_ip_info_response(res)
      banners = res['data'].map do |banner|
        {
          port: banner['port'],
          timestamp: banner['timestamp'],
          data: banner['data']
        }
      end

      {
        isp: res['isp'],
        location: {
          region: res['region_code'],
          country: res['country_name'],
          city: res['city'],
          latitude: res['latitude'],
          longitude: res['longitude']
        },
        banners: banners
      }
    end
  end
end