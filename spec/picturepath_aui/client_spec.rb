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
