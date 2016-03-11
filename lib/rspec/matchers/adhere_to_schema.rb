require "rspec/matchers/adhere_to_schema/identity"
require "pathname"
require "rspec/matcher"
require "json-schema"

module RSpec
  module Matchers
    # Check if given data matches a json schema.
    #
    # Includes jsonapi.org schema, supports passing objects as schemas or
    # schema files under spec/schemas/NAME.json.
    #
    # @example
    #   it "is jsonapi compatible and follows article schema" do
    #     expect(data).to adhere_to_schema(:article_schema).and_jsonapi
    #   end
    # @note You can use adhere_to_jsonapi to just make sure data follows
    #   jsonapi.
    class AdhereToSchema
      include RSpec::Matcher
      JSONAPI = Pathname.new(__FILE__).join("..", "..", "..", "..", "vendor", "jsonapi.schema").to_s

      register_as :adhere_to_schema
      register_as :adhere_to_jsonapi, jsonapi: true
      attr_accessor :jsonapi, :errors

      # @method jsonapi
      # @api private
      # @return [Boolean]

      # @method errors
      # @api private
      # @return [Array]

      # Defines schemas dir, Feel free to replace with another string.
      # @return [String]
      def self.schema_dir
        File.expand_path(File.join(RSpec.configuration.default_path, "schemas"))
      end

      # @api private
      # @note Errors are created on the fly in an append only style
      def initialize
        self.errors = []
      end

      # @api private
      # Main logic
      # @note uses throw as control flow
      def match
        validate_input
        validate_with_schema schema  if schema?
        validate_with_schema JSONAPI if jsonapi?

        true
      end

      # @api private
      def failure_message
        <<-MSG.gsub(/^\s+/, " ")
          expected data to match against #{schema_name} schema but data had following errors.
          errors:
          #{errors}
          ----
          data:
          #{data}
        MSG
      end

      # @api private
      def failure_message_when_negated
        "expected data to not match #{schema_name} but it did."
      end

      # Indicates that matcher should try to match agains jsonapi too
      # @return [self]
      def and_jsonapi
        self.jsonapi = true

        self
      end

      private

      alias_method :schema_name, :expected
      alias_method :data, :actual

      def schema
        return schema_name if schema_name.is_a? Hash
        File.join self.class.schema_dir, "#{schema_name}.json"
      end

      def schema?
        !undefined?
      end

      def jsonapi?
        jsonapi == true
      end

      def valid_schema?
        return true if undefined?

        schema.is_a?(Hash) || File.exist?(schema)
      end

      # @api private
      # @note Throws
      def validate_input
        raise "#{schema} does not exist" unless valid_schema?
        resolve_expectation if data.nil? || data == "" # There is no data to validate
      end

      # @api private
      # @note Throws
      def validate_with_schema file
        return true if JSON::Validator.validate(file, data)
        self.errors += JSON::Validator.fully_validate(file, data)
        reject_expectation
      end
    end
  end
end
