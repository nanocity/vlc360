module VLC360
  module APIResource

    def self.included(base)
      base.extend ClassMethods
    end

    def process_response(response)
      return true if (200..299) === response.code

      @errors << response.parsed_response['error']
      @errors.compact!

      return false
    end

    module ClassMethods
      def client
        VLC360.client
      end

      attr_accessor :rekey_attributes

      def rekey_attribute(attr, callable)
        (@rekey_attributes ||= {})[attr] = callable
      end

      private

      def initialize_from_response(response)
        data = response.parsed_response

        # List and Search always return an Array even though it may be empty.
        if data.is_a? Array
          data.map { |element| new(element.deep_rekey { |k| k.underscore.to_sym }) }

        # Find and Save returns a Hash with a status associated
        elsif data.is_a? Hash
          resource = new(data['data'].deep_rekey { |k| k.underscore.to_sym })
          if data['status'] == 'error'
            resource.errors << data['message']
          end
          resource
        end
      end
    end
  end
end
