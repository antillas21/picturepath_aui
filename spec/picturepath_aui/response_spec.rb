require 'spec_helper'

RSpec.describe PicturepathAUI::Response do
  describe 'an instance' do
    it 'receives plain XML as argument' do
      expect { PicturepathAUI::Response.new }.to raise_error(ArgumentError)
    end

    it 'stores XML in :raw attribute' do
      xml = File.open('./spec/fixtures/success_check.xml').read
      response = PicturepathAUI::Response.new(xml)
      expect(response.raw).to eq(xml)
    end

    it 'parses XML and stores a Hash structure in :data attribute' do
      xml = File.open('./spec/fixtures/success_check.xml').read
      response = PicturepathAUI::Response.new(xml)
      expect(response.data).to be_a(Hash)
    end
  end

  describe 'statuses' do
    context '#success?' do
      it 'status is 0' do
        xml = File.open('./spec/fixtures/success_submission.xml').read
        response = PicturepathAUI::Response.new(xml)
        expect(response.success?).to eq(true)
      end

      it 'status is 1' do
        xml = File.open('./spec/fixtures/partial_success_submission.xml').read
        response = PicturepathAUI::Response.new(xml)
        expect(response.success?).to eq(true)
      end

      it 'status is 2' do
        xml = File.open('./spec/fixtures/success_check.xml').read
        response = PicturepathAUI::Response.new(xml)
        expect(response.success?).to eq(true)
      end

      it 'status is 3' do
        xml = File.open('./spec/fixtures/partial_success_check.xml').read
        response = PicturepathAUI::Response.new(xml)
        expect(response.success?).to eq(true)
      end
    end

    context '#error?' do
      it 'status not in warning' do
        xml = File.open('./spec/fixtures/failed_check.xml').read
        response = PicturepathAUI::Response.new(xml)
        expect(response.error?).to eq(true)
        expect(response.success?).to eq(false)
      end

      it 'status not in success' do
        xml = File.open('./spec/fixtures/failed_submission.xml').read
        response = PicturepathAUI::Response.new(xml)
        expect(response.error?).to eq(true)
        expect(response.success?).to eq(false)
      end
    end
  end

  describe '#order_number' do
    context 'submit requests' do
      let(:success) { PicturepathAUI::Response.new(read('success_submission.xml')) }
      let(:partial) { PicturepathAUI::Response.new(read('partial_success_submission.xml')) }
      let(:error) { PicturepathAUI::Response.new(read('failed_submission.xml')) }

      it 'is present on success responses' do
        expect(success.order_number).to_not be_nil
        expect(success.order_number).to eq('CKBNV6X6')
      end

      it 'is present on partial success responses' do
        expect(partial.order_number).to_not be_nil
        expect(partial.order_number).to eq('CKBNV6X6')
      end

      it 'is present on error responses' do
        expect(error.order_number).to_not be_nil
        expect(error.order_number).to eq('CNC6N464')
      end
    end

    context 'check requests' do
      let(:success) { PicturepathAUI::Response.new(read('success_check.xml')) }
      let(:partial) { PicturepathAUI::Response.new(read('partial_success_check.xml')) }
      let(:error) { PicturepathAUI::Response.new(read('failed_check.xml')) }

      it 'is not present on success responses' do
        expect(success.order_number).to be_nil
      end

      it 'is not present on partial success responses' do
        expect(partial.order_number).to be_nil
      end

      it 'is not present on error responses' do
        expect(error.order_number).to be_nil
      end
    end
  end

  describe '#messages' do
    it 'is an Array of strings' do
      xml_1 = File.open('./spec/fixtures/success_check.xml').read
      xml_2 = File.open('./spec/fixtures/partial_success_check.xml').read
      xml_3 = File.open('./spec/fixtures/failed_submission.xml').read
      xml_4 = File.open('./spec/fixtures/failed_check.xml').read
      xml_5 = File.open('./spec/fixtures/success_submission.xml').read
      xml_6 = File.open('./spec/fixtures/partial_success_submission.xml').read

      single_message_response = PicturepathAUI::Response.new(xml_1)
      multi_message_response = PicturepathAUI::Response.new(xml_2)
      multi_message_response_b = PicturepathAUI::Response.new(xml_3)
      multi_message_response_c = PicturepathAUI::Response.new(xml_4)
      multi_message_response_d = PicturepathAUI::Response.new(xml_5)
      multi_message_response_e = PicturepathAUI::Response.new(xml_6)

      expect(single_message_response.messages).to be_a(Array)
      expect(multi_message_response.messages).to be_a(Array)
      expect(multi_message_response_b.messages).to be_a(Array)
      expect(multi_message_response_c.messages).to be_a(Array)
      expect(multi_message_response_d.messages).to be_a(Array)
      expect(multi_message_response_e.messages).to be_a(Array)
    end
  end
end

def read(xml_file)
  return File.open("./spec/fixtures/#{xml_file}").read
end
