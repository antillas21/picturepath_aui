require 'spec_helper'

module PicturepathAUI
  class Client
    private

    def post_request(action, payload)
      url = (api_url + aui_default_params(action) + payload_params(payload)).to_s
      return url
    end
  end
end

RSpec.describe PicturepathAUI::Client do
  describe 'an instance' do
    it 'requires a :username' do
      expect { PicturepathAUI::Client.new(password: "password") }.to raise_error(
        KeyError)
    end

    it 'requires a :password' do
      expect { PicturepathAUI::Client.new(username: "username") }.to raise_error(
        KeyError)
    end

    describe 'URL safe params' do
      let(:client) { PicturepathAUI::Client.new(username: "a username", password: "has a password") }

      it 'escapes username to be valid when passed as URL params' do
        expect(client.send(:escape, client.username)).to eq("a+username")
      end

      it 'escapes password to be valid when passed as URL params' do
        expect(client.send(:escape, client.password)).to eq("has+a+password")
      end
    end
  end

  describe '#check' do
    let(:client) { PicturepathAUI::Client.new(username: "username", password: "password") }
    let(:payload) { File.read('./spec/fixtures/request.xml') }

    it 'requires a payload' do
      expect { client.check }.to raise_error(ArgumentError)
    end

    it 'performs a :check request to AUI API' do
      expect(client).to receive(:post_request).with(:check, payload)
      client.check(payload)
    end

    describe 'payload argument' do
      let(:request) do
        PicturepathAUI::Request.new({
          site: 2845, order_number: 1234, product_line: "LINK",
          street1: "742 Evergreen Terrace", street2: nil, city: "Springfield",
          state: "IL", zip_code: 62701, mls_id: 5678,
          tour_url: "http://www.realestateagent.com/tours?id=12345678"
        })
      end

      it 'can receive a PicturepathAUI::Request object' do
        expect { client.check(request) }.to_not raise_error
      end

      it 'can receive straight XML' do
        expect { client.check(payload) }.to_not raise_error
      end
    end
  end

  describe '#submit' do
    let(:client) { PicturepathAUI::Client.new(username: "username", password: "password") }
    let(:payload) { File.read('./spec/fixtures/request.xml') }

    it 'requires a payload' do
      expect { client.submit }.to raise_error(ArgumentError)
    end

    it 'performs a :submit request to AUI API' do
      expect(client).to receive(:post_request).with(:submit, payload)
      client.submit(payload)
    end

    describe 'payload argument' do
      let(:request) do
        PicturepathAUI::Request.new({
          site: 2845, order_number: 1234, product_line: "LINK",
          street1: "742 Evergreen Terrace", street2: nil, city: "Springfield",
          state: "IL", zip_code: 62701, mls_id: 5678,
          tour_url: "http://www.realestateagent.com/tours?id=12345678"
        })
      end

      it 'can receive a PicturepathAUI::Request object' do
        expect { client.submit(request) }.to_not raise_error
      end

      it 'can receive straight XML' do
        expect { client.submit(payload) }.to_not raise_error
      end
    end
  end
end
