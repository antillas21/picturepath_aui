require 'builder'

module PicturepathAUI
  class Request
    attr_accessor :customer_number, :order_number, :product_sku, :product_line,
      :street1, :street2, :city, :state, :zip_code, :country, :mls_id, :tour_url,
      :site, :api_version

    def initialize(attrs = {})
      [
        :customer_number, :order_number, :product_sku, :product_line,
        :street1, :street2, :city, :state, :zip_code, :country, :mls_id,
        :tour_url, :site
      ].each do |key|
        self.instance_variable_set("@#{key}", attrs.fetch(key, nil))
      end

      @api_version = attrs.fetch(:api_version, "5.1")
    end

    def to_xml
      xml = build_xml_document
      return xml
    end

    private

    def build_xml_document
      _xml = Builder::XmlMarkup.new(target: "", indent: 2)
      _xml.instruct!
      _xml.AUI_SUBMISSION(VERSION: api_version) {
        _xml.TOUR {
          _xml.CUSTREFNUM customer_number
          _xml.ORDERNUM order_number
          _xml.PRODUCT_LINE product_line
          _xml.ADDRESS {
            _xml.STREET1 street1
            _xml.STREET2 street2
            _xml.CITY city
            _xml.STATE state
            _xml.COUNTRY(CODE: (country || "USA"))
            _xml.ZIP zip_code
          }
          _xml.IDENTIFIERS {
            _xml.ID1(VALUE: mls_id, TYPE: "MLSID")
            _xml.ID2(VALUE: "", TYPE: "MLSID")
          }
          _xml.DISTRIBUTION {
            [site].flatten.each do |s|
              _xml.SITE s
            end
          }
          _xml.TOUR_URL tour_url
        }
      }
    end
  end
end
