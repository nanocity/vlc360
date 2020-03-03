module VLC360
  module APIOperations
    module Save
      def save
        clear_errors

        process_response(
          self.class.client.request(
            self.class::SAVE_URL,
            to_hash.deep_rekey do |key|
              if self.class.rekey_attributes&.include?(key)
                self.class.rekey_attributes[key].call(key)
              else
                key.to_s.camelcase(:upper)
              end
            end
          )
        )
      end
    end
  end
end
