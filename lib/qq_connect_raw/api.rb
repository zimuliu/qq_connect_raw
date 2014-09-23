module QQConnectRaw
  ENDPOINT = 'https://graph.qq.com'.freeze

  OAUTH_AUTHORIZE_PATH = "/oauth2.0/authorize".freeze
  OAUTH_TOKEN_PATH = "/oauth2.0/token".freeze

  REST_PATH = "#{ENDPOINT}/".freeze


  class QQConnect
    # Authenticated access token
    attr_reader :access_token

    # QQConnect ID of authenticated user
    attr_reader :uid

    def initialize(access_token, uid) # :nodoc:
      if QQConnectRaw.app_id.nil? or QQConnectRaw.app_key.nil?
        raise NotConfigured.new("API ID or key are not defined!")
      end

      if access_token.nil? or uid.nil?
        raise NotConfigured.new("Access token and uid are mandatory!")
      end

      @access_token = access_token
      @uid = uid

      @oauth_consumer = OAuth2::Client.new(QQConnectRaw.app_id, QQConnectRaw.app_key,
                                           :site => ENDPOINT,
                                           :authorize_url => OAUTH_AUTHORIZE_PATH,
                                           :token_url => OAUTH_TOKEN_PATH,
                                           :token_method => :get)

      @oauth_token = OAuth2::AccessToken.new(oauth_client, @access_token,
                                             :mode => :query,
                                             :param_name => 'access_token')
    end

    def call(method, path, params={}, &block)
      http_response = @oauth_request.request(method, path, :params => build_params(params))
      process_response(method, path, http_response.body)
    end

    def get(path, params={}, &block)
      call(:get, params, &block)
    end

    private

    def build_params(params={})
      params.merge('format' => 'json',
                   'oauth_consumer_key' => QQConnectRaw.app_id,
                   'openid' => @uid)
    end

    def process_response(method, path, response)
      json = JSON.load(response.empty? ? "{}" : response)
      raise FailedResponse.new(json['msg'], json['ret'], method, path) if json['ret'] != 0

      json
    end

  end
end
