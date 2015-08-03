require 'spec_helper'

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

    it 'auto-assigns API version 5.1' do
      client = PicturepathAUI::Client.new(username: "username", password: "password")
      expect(client.api_version).to eq("5.1")
    end

    it 'can receive a custom :api_version' do
      client = PicturepathAUI::Client.new(
        username: "username", password: "password",
        api_version: "5.0"
      )
      expect(client.api_version).to eq("5.0")
    end
  end

  describe '#check' do
    let(:client) { PicturepathAUI::Client.new(username: "username", password: "password") }

    it 'requires a payload' do
      expect { client.check }.to raise_error(ArgumentError)
    end

    it 'performs a :check request to AUI API'
  end

  describe '#submit' do
    let(:client) { PicturepathAUI::Client.new(username: "username", password: "password") }

    it 'requires a payload' do
      expect { client.submit }.to raise_error(ArgumentError)
    end

    it 'performs a :submit request to AUI API'
  end
end
