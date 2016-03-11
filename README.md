# RSpec Matcher `adhere_to_schema`

[![Gem Version](https://badge.fury.io/rb/rspec-matchers-adhere_to_schema.svg)](http://badge.fury.io/rb/rspec-matchers-adhere_to_schema)
[![Code Climate GPA](https://codeclimate.com/github//rspec-matchers-adhere_to_schema.svg)](https://codeclimate.com/github/pekhee/rspec-matchers-adhere_to_schema)
[![Code Climate Coverage](https://codeclimate.com/github//rspec-matchers-adhere_to_schema/coverage.svg)](https://codeclimate.com/github/pekhee/rspec-matchers-adhere_to_schema)
[![Gemnasium Status](https://gemnasium.com//rspec-matchers-adhere_to_schema.svg)](https://gemnasium.com/pekhee/rspec-matchers-adhere_to_schema)
[![Travis CI Status](https://secure.travis-ci.org//rspec-matchers-adhere_to_schema.svg)](https://travis-ci.org/pekhee/rspec-matchers-adhere_to_schema)

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

# Features

- Test if some data adheres to specified json schema
- Define json schema in a schemas directory and they will be automatically
picked

# Requirements

0. [MRI 2.2.3](https://www.ruby-lang.org)
1. [RSpec 3.x](http://rspec.info)

# Setup

To install, type the following:

    gem install rspec-matchers-adhere_to_schema

Add the following to your Gemfile:

    gem "rspec-matchers-adhere_to_schema"

This gem is signed. Use pekhee.pem as public key.

# Usage

    RSpec.describe "a user document" do
      subject do
        JSON.parse <<-JSON_DOC
          {
            firstName: "Pooyan",
            lastName: "Khosravi"
          }
        JSON_DOC
      end

      let :user_schema do
        JSON.parse <<-JSON_SCHEMA
          {
            "title": "User Schema",
            "type": "object",
            "properties": {
              "firstName": {
                "type": "string"
              },
              "lastName": {
                "type": "string"
              },
              "age": {
                "description": "Age in years",
                "type": "integer",
                "minimum": 0
              }
            },
            "required": ["firstName", "lastName"]
          }
        JSON_SCHEMA
      end

      it "adheres to user schema" do
        expect(subject).to match_schema user_schema
        expect(subject).to matche_schema :user # spec/schemas/user.json
      end
    end

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2016 [Pooyan Khosravi]().
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Pooyan Khosravi]().
