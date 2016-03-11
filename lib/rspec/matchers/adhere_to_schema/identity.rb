module RSpec
  module Matchers
    class AdhereToSchema
      # Gem identity information.
      module Identity
        def self.name
          "rspec-matchers-adhere_to_schema"
        end

        def self.label
          "RSpec::Matchers::AdhereToSchema"
        end

        def self.version
          "0.1.0"
        end

        def self.version_label
          "#{label} #{version}"
        end
      end
    end
  end
end
