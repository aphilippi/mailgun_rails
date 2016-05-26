require 'rest_client'


module Mailgun
  class Client
    attr_reader :api_key, :domain

    def initialize(api_key, domain)
      @api_key = api_key
      @domain = domain
    end

    def send_message(options)
      RestClient::Resource.new(mailgun_url, 
                               timeout: (ENV['MAILGUN_REST_CLIENT_TIMEOUT'] || 180).to_i,
                               open_timeout: (ENV['MAILGUN_REST_CLIENT_TIMEOUT'] || 180).to_i
                               ).post options
    end

    def mailgun_url
      api_url+"/messages"
    end

    def api_url
      "https://api:#{api_key}@api.mailgun.net/v3/#{domain}"
    end
  end
end
