class ClientsController < ApplicationController
  def info
    begin
      client_ip = IPAddr.new(request.remote_ip)
      if client_ip.loopback?
        client_ip = Rails.cache.fetch("ip:local", expires_in: 7.days) do
          Shodan.my_ip()
        end
      end
    rescue IPAddr::InvalidAddressError => e
      render status: :unprocessable_entity, json: {
        error: e.message
      }
      return
    end

    client_ip_info = Rails.cache.fetch("ip:#{client_ip.to_s}", expires_in: 7.days) do
      Shodan.ip_info(client_ip.to_s)
    end

    render status: :ok, json: client_ip_info
  end
end
