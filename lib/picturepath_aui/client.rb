module PicturepathAUI
  class Client
    attr_reader :api_version

    def initialize(attributes = {})
      @username = attributes.fetch(:username)
      @password = attributes.fetch(:password)
      @api_version = attributes.fetch(:api_version, "5.1")
    end

    def check(payload)
    end

    def submit(payload)
    end
  end
end
