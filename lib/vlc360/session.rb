module VLC360
  class Session < Resource
    include APIResource
    include APIOperations::Save

    SAVE_URL = '/api/Auth/loginUserService'

    attributes :user, :password, :token_session, :expires

    def initialize(attributes = {})
      @token_session = nil
      @expires = nil

      super
    end

    def persisted?
      @token_session == nil
    end

    def process_response(data)
      super(data).tap do |result|
        if result
          @token_session = data.parsed_response['TokenSession']
          @expired = Date.parse(data.parsed_response['Expires'])
        end
      end
    end
  end
end
