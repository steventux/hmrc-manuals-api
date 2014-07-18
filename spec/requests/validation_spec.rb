require 'rails_helper'

describe "validation" do
  let(:malformed_json) { "[" }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:manual_without_title) { m = valid_manual; m.delete(:title); m }
  let(:section_without_title) { s = valid_section; s.delete(:title); s }

  context "for manuals" do
    it "detects malformed JSON" do
      put '/hmrc-manuals/imaginary-slug', malformed_json, headers

      expect(response.status).to eq(400)
      expect(json_response).to include("status" => "error")
      expect(json_response["errors"].first).to match(%r{Request JSON could not be parsed:})
    end

    it "validates for the presence of the title" do
      put_json '/hmrc-manuals/imaginary-slug', manual_without_title

      expect(response.status).to eq(422)
      expect(json_response).to include("status" => "error")
      expect(json_response["errors"].first).to match(%r{#: failed schema #: Missing required keys \"title\" in object})
    end
  end

  context "for manual sections" do
    it "detects malformed JSON" do
      put '/hmrc-manuals/imaginary-slug/sections/imaginary-section', malformed_json, headers

      expect(response.status).to eq(400)
      expect(json_response).to include("status" => "error")
      expect(json_response["errors"].first).to match(%r{Request JSON could not be parsed:})
    end

    it "validates for the presence of the title" do
      put_json '/hmrc-manuals/imaginary-slug/sections/imaginary-section', section_without_title

      expect(response.status).to eq(422)
      expect(json_response).to include("status" => "error")
      expect(json_response["errors"].first).to match(%r{#: failed schema #: Missing required keys \"title\" in object})
    end
  end
end
