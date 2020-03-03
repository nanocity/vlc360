module VLC360
  module APIOperations
    module List

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def list
          initialize_from_response(client.request(self::LIST_URL))
        end
      end
    end
  end
end
