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
  end
end
