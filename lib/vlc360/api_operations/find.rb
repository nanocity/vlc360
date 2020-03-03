module VLC360
  module APIOperations
    module Find

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def find(id)
          resource = initialize_from_response(client.request(self::FIND_URL, { porposalId: id }))
          raise ExperienceNotFound unless resource.valid?
          resource
        end
      end
    end
  end
end
