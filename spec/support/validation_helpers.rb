module ValidationHelpers
  def get_validation_errors(schema, data)
    validator = JsonSchema::Validator.new(schema)
    validator.validate(JSON.parse(data.to_json))
    JsonSchema::SchemaError.aggregate(validator.errors)
  end
end

RSpec.configuration.include ValidationHelpers
