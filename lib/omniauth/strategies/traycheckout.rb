require "oauth2"
require "omniauth"
require "active_support"
require "json"
module OmniAuth
  module Strategies
    class Traycheckout
      include OmniAuth::Strategy

      option :name, :traycheckout

      args [:consumer_key, :consumer_secret]

      option :consumer_key, nil
      option :consumer_secret, nil

      option :client_options, {
        site: 'https://portal.traycheckout.com.br',
        authorize_url: '/authentication',
        token_url: 'https://api.traycheckout.com.br/api/authorizations/access_token'
      }

      attr_accessor :access_token

      def client
        ::OAuth2::Client.new(options.consumer_key,
                             options.consumer_secret,
                             deep_symbolize(options.client_options))
      end

      credentials do
        hash = { access_token: access_token.token }
        hash.merge!(refresh_token: access_token.refresh_token) if access_token.expires? && access_token.refresh_token
        hash.merge!(expires_at: access_token.expires_at) if access_token.expires?
        hash.merge!(expires: access_token.expires?)
        hash
      end

      def request_phase
        redirect client.authorize_url(authorize_params)
      end

      def authorize_params
        { consumer_key: options.consumer_key }
      end

      def token_params
        options.token_params.merge(options_for("token"))
      end

      def callback_phase
        if request.params["code"].blank?
          fail!('code_blank', CallbackError.new(:code_blank, 'code can not be blank'))
        else
          self.access_token = build_access_token
          super
        end
      end

      def auth_hash
        self.credentials
      end

    protected

      def build_access_token
        response = client.request(:post, client.token_url, data_request_access_token)
        access_token_opts = JSON.parse(response.body)['data_response']['authorization']
        ::OAuth2::AccessToken.from_hash(client, { access_token: access_token_opts['access_token'],
                                                  expires_at: access_token_opts['access_token_expiration'].to_time,
                                                  refresh_token: access_token_opts['refresh_token'],
                                                  redirect_uri: callback_url })
      end

      def data_request_access_token
        opts = {}
        opts[:headers] = {'Content-Type' => 'application/x-www-form-urlencoded'}
        opts[:body] = { code: request.params["code"],
                        consumer_key: options.consumer_key,
                        consumer_secret: options.consumer_secret,
                        type_response: 'J' }
        opts
      end

      def deep_symbolize(options)
        hash = {}
        options.each do |key, value|
          hash[key.to_sym] = value.is_a?(Hash) ? deep_symbolize(value) : value
        end
        hash
      end

      # An error that is indicated in the OAuth 2.0 callback.
      # This could be a `redirect_uri_mismatch` or other
      class CallbackError < StandardError
        attr_accessor :error, :error_reason, :error_uri

        def initialize(error, error_reason = nil, error_uri = nil)
          self.error = error
          self.error_reason = error_reason
          self.error_uri = error_uri
        end

        def message
          [error, error_reason, error_uri].compact.join(" | ")
        end
      end


    end
  end
end

OmniAuth.config.add_camelization 'traycheckout', 'Traycheckout'
