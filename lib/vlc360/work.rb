module VLC360
  class Work < Resource
    include APIResource
    include APIOperations::Save

    SAVE_URL = '/api/customerPortalWebServices/work'

    attributes :id, :cod_ext, :activity_id, :description, :urgent, :inner_commpany_id
    rekey_attribute :activity_id, ->(key) { 'ActivityID' }
    rekey_attribute :inner_commpany_id, ->(key) { 'InnerCommpanyID' }
    rekey_attribute :cif, ->(key) { key.to_s.upcase }

    nested_resource :injured

    def initialize(attributes = {})
      @id = -1

      super
    end

    def persisted?
      @id != -1
    end

    def process_response(data)
      super(data).tap do |result|
        @id = data.parsed_response['ServiceID'] if result
      end
    end
  end
end
