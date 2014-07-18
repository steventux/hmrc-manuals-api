require 'rails_helper'

describe 'section schema' do
  context 'a minimal document' do
    let(:errors) { get_validation_errors(SECTION_SCHEMA, valid_section) }

    it 'should be valid' do
      expect(errors).to eql([])
    end
  end

  context 'a maximal document' do
    let(:errors) do
      get_validation_errors(SECTION_SCHEMA, maximal_section)
    end

    it 'should be valid' do
      expect(errors).to eql([])
    end
  end
end
