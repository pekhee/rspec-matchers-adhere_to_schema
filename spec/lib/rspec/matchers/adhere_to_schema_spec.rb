require "spec_helper"

describe "RSpec::Matchers::AdhereToSchema" do
  subject :data do
    JSON.parse samples_dir.join("user.json").read
  end

  let :spec_dir do
    Pathname.new(RSpec.configuration.default_path)
  end

  let :samples_dir do
    spec_dir.join("samples")
  end

  let :schemas_dir do
    spec_dir.join("schemas")
  end

  let :user_schema do
    JSON.parse schemas_dir.join("user.json").read
  end

  it "accepts an object as schema definition" do
    expect(data).to adhere_to_schema user_schema
  end

  it "loads schema from spec/schema/NAME.json" do
    expect(data).to adhere_to_schema :user
  end

  context "jsonapi" do
    subject :data do
      samples_dir.join("articles.json").read
    end

    it "has a matcher for it" do
      expect(data).to adhere_to_jsonapi
    end

    describe "#and_jsonapi" do
      it "also checks for jsonapi compatibility" do
        expect(data).to adhere_to_schema(:article_schema).and_jsonapi
      end
    end
  end
end
