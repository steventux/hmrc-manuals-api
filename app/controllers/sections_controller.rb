class SectionsController < ApplicationController
  before_filter :parse_request_body, only: [:update]

  def update
    validator = JsonSchema::Validator.new(SECTION_SCHEMA)
    validator.validate(@parsed_request_body)
    if validator.errors.empty?
      render nothing: true, content_type: "application/json", status: 200
    else
      render json: { status: "error", errors: JsonSchema::SchemaError.aggregate(validator.errors) }, status: 422
    end
  end
end
