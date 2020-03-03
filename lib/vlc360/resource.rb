module VLC360
  class Resource
    class << self
      def attributes(*attributes)
        attr_accessor(*attributes)
        (@attributes ||= []).push(*attributes)
      end

      def nested_resources(*resources)
        attr_accessor(*resources)
        (@nested_resources ||= []).push(*resources)
      end

      def nested_resource(resource = nil)
        return @nested_resource unless resource

        attr_accessor(resource)
        @nested_resource = resource
      end

      def new_from_hash(attrs, type)
        VLC360.const_get(type.capitalize).new(attrs)
      end
    end

    attr_reader :errors, :warnings

    def initialize(attributes = {})
      clear_errors
      set_attributes(attributes)
    end

    def set_attributes(attributes)
      attributes.each do |key, value|
        if self.class.attributes.include?(key.to_sym)
          send("#{key}=", value)
        elsif self.class.nested_resource == key.to_sym
          send("#{key}=", Resource.new_from_hash(value, key))
        elsif self.class.nested_resources.include?(key.to_sym)
          send("#{key}=", (value || []).map{ |attrs| Resource.new_from_hash(attrs, key) })
        end
      end
    end

    def valid?
      errors.empty?
    end

    def to_hash
      hashie = Hash[self.class.attributes.map { |attribute| [attribute, send(attribute)] }]
      hashie[self.class.nested_resource] = send(self.class.nested_resource).to_hash if self.class.nested_resource

      self.class.nested_resources.map do |resources|
        hashie[resources] = send(resources)&.map(&:to_hash)
      end

      hashie.delete_if { |k, v| k.nil? || v.nil? }
    end

    private

    def clear_errors
      @errors = []
      @warnings = []
    end
  end
end
