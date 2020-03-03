module VLC360
  module APIOperations
    module Translate
      def translate(locale, attributes)
        translated = deep_clone
        translated.set_attributes(attributes)

        permitted = %i[title description book_url book_email date_description images videos]
        translated.class.attributes.each do |attr|
          translated.send("#{attr}=", nil) unless permitted.include?(attr)
        end

        translated.process_response(
          self.class.client.request(
            self.class::TRANSLATE_URL,
            translated.to_hash.deep_rekey { |k| k.to_s.camelcase(:lower) },
            {},
            { locale: locale, id: id }
          ).parsed_response
        )

        translated
      end
    end
  end
end
