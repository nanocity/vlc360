module VLC360
  module APIOperations
    module Validate
      def validate
        validation = VLC360::Validation.new
        validation.process_response(
          self.class.client.request(
            self.class::VALIDATE_URL,
            { porposalId: id },
          ).parsed_response
        )

        validation
      end
    end
  end
end
