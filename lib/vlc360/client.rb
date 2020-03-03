module VLC360
  class Client
    include HTTParty
    format :json

    attr_accessor :locale

    def request(url, body = {}, headers = {})
      self.class.base_uri VLC360.base_uri

      self.class.post(
        url,
        body: body.to_json,
        headers: default_headers.merge(headers)
      )
    end

    private

    def default_headers
      {
        'Content-Type'   => 'application/json',
        'Accept'         => 'application/json',
        'Accept-Charset' => 'UTF-8',
        'CommpanyID'     => VLC360.company_id.to_s,
        'TokenSession'   => VLC360.token_session.to_s,
        'x-api-key'      => VLC360.api_key.to_s
      }
    end
  end
end
