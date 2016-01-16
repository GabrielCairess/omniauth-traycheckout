require 'spec_helper'

describe OmniAuth::Strategies::Traycheckout do
  subject do
    strategy = OmniAuth::Strategies::Traycheckout.new(nil, @options || {})
    allow(strategy).to receive(:session).and_return({})
    strategy
  end

  it 'has a version number' do
    expect(Omniauth::Traycheckout::VERSION).not_to be nil
  end

  describe '#client' do
    it 'have the correct TrayCheckout site' do
      expect(subject.client.site).to eq("https://portal.traycheckout.com.br")
    end

    it 'have the correct authorization url' do
      expect(subject.client.options[:authorize_url]).to eq("/authentication")
    end

    it 'have the correct token url' do
      expect(subject.client.options[:token_url]).to eq('https://api.traycheckout.com.br/api/authorizations/access_token')
    end
  end

  describe '#callback_path' do
    it 'have the correct callback path' do
      expect(subject.callback_path).to eq('/auth/traycheckout/callback')
    end
  end
end
