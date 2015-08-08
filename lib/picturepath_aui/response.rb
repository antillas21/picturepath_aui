require 'nori'
require 'nokogiri'

module PicturepathAUI
  class Response
    attr_reader :raw, :data, :status_code, :messages, :order_number

    def initialize(xml)
      @raw = xml
      @data = parser.parse(xml)[:aui_response]
      @status_code = extract_status(@data)
      @messages = extract_messages(@data)
      @order_number = extract_order_number(@data)
    end

    def success?
      ["SUCCESS", "PARTIAL SUCCESS"].include?(status_code)
    end

    def error?
      status_code == "ERROR"
    end

    def warning?
      ["WARNING", "GENERAL WARNING"].include?(status_code)
    end

    def system_unavailable?
      status_code == "SYSTEM UNAVAILABLE"
    end

    private

    def parser
      return Nori.new(convert_tags_to: lambda { |tag| tag.snakecase.to_sym })
    end

    def extract_status(data)
      return data[:status][:@value]
    end

    def extract_messages(data)
      messages = [data[:status][:message]].flatten.map do |message|
        return [message] if message.is_a?(String)
        message[:@description]
      end

      return messages.flatten
    end

    def extract_order_number(data)
      return nil if is_check_request?(data)
      return from_status_message(data) if data[:order_number].nil?
      data[:order_number]
    end

    def from_status_message(data)
      /order number (\w+)/.match(data[:status][:message].to_s)[1]
    end

    def is_check_request?(data)
      data[:status][:@action] == "CHECK"
    end
  end
end
