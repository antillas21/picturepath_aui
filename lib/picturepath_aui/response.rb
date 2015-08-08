require 'nori'
require 'nokogiri'

module PicturepathAUI
  class Response
    attr_reader :raw, :data, :status, :messages, :order_number

    def initialize(xml)
      @raw = xml
      @data = parser.parse(xml)[:aui_response]
      @status = extract_status(@data)
      @messages = extract_messages(@data)
      @order_number = extract_order_number(@data)
    end

    def success?
      ["SUCCESS", "PARTIAL SUCCESS"].include?(status)
    end

    def error?
      status == "ERROR"
    end

    def warning?
      ["WARNING", "GENERAL WARNING"].include?(status)
    end

    def system_unavailable?
      status == "SYSTEM UNAVAILABLE"
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
        return [message.strip] if message.is_a?(String)
        message[:@description].strip
      end

      return messages.flatten
    end

    def extract_order_number(data)
      return nil if is_check_request?(data)
      return from_status_message(data) if data[:order_number].nil?
      data[:order_number]
    end

    def from_status_message(data)
      order_info = /order number (\w+)/.match(data[:status][:message].to_s)
      return order_info[1] if order_info.is_a?(MatchData)
    end

    def is_check_request?(data)
      data[:status][:@action] == "CHECK"
    end
  end
end
