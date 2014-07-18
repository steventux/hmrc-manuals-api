require 'rails_helper'

describe 'manual schema' do
  context 'a minimal document' do

    let(:errors) {
      get_validation_errors(MANUAL_SCHEMA, valid_manual) }

    it 'should be valid' do
      expect(errors).to eql([])
    end
  end

  context 'a maximal document' do
    let(:errors) do
      get_validation_errors(MANUAL_SCHEMA, maximal_manual)
    end

    it 'should be valid' do
      expect(errors).to eql([])
    end
  end
end
