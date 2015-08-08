require 'cgi'
require 'open-uri'

module PicturepathAUI
  class Client
    attr_reader :api_version, :username, :password

    def initialize(attributes = {})
      @username = attributes.fetch(:username)
      @password = attributes.fetch(:password)
      @api_version = attributes.fetch(:api_version, "5.1")
    end

    def check(payload)
      post_request(:check, payload)
    end

    def submit(payload)
      post_request(:submit, payload)
    end

    private

    def escape(attribute)
      return CGI.escape(attribute)
    end

    def post_request(action, payload)
      payload = payload.to_xml if payload.is_a?(Request)
      url = (api_url + aui_default_params(action) + payload_params(payload)).to_s
      xml = open(url).read
      return Response.new(xml)
    end

    def api_url
      "http://picturepath.homestore.com/picturepath/cgi-bin/receiver.pl"
    end

    def aui_default_params(action)
      action_string = action.to_s.capitalize
      "?username=#{escape(username)}&password=#{escape(password)}&client=AUI&" +
      "version=#{api_version}&action=#{action_string}"
    end

    def payload_params(payload)
      "&xml=#{escape(payload)}"
    end
  end
end
