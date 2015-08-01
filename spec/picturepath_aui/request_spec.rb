require 'spec_helper'

RSpec.describe PicturepathAUI::Request do
  describe 'an instance' do
    it 'receives an attributes Hash' do
      expect {
        PicturepathAUI::Request.new({
          site: 2845, order_number: 1234, product_line: "LINK",
          street1: "742 Evergreen Terrace", street2: nil,
          city: "Springfield", state: "IL", zip_code: 62701,
          mls_id: 5678,
          tour_url: "http://www.realestateagent.com/tours?id=12345678"
        })
        }.to_not raise_error
    end

    it 'sets a getter/setter method for each attribute in Hash' do
      request = PicturepathAUI::Request.new({
        site: 2845, order_number: 1234, product_line: "LINK",
        street1: "742 Evergreen Terrace", street2: nil,
        city: "Springfield", state: "IL", zip_code: 62701,
        mls_id: 5678,
        tour_url: "http://www.realestateagent.com/tours?id=12345678"
      })

      keys = [
        :site, :order_number, :product_line, :street1, :street2,
        :city, :state, :zip_code, :mls_id, :tour_url
      ]
      
      keys.each do |key|
        getter = key
        setter = "#{key.to_s}=".to_sym

        expect(request).to respond_to(getter)
        expect(request).to respond_to(setter)
      end
    end
  end

  describe '#to_xml' do
    it 'converts attributes to PicturePath AUI API required XML format'
  end
end
