module VLC360
  module APIOperations
    module Search

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def search(title)
          initialize_from_response(client.request(self::SEARCH_URL, { porposalTitle: title }))
        end
      end
    end
  end
end
