require 'struct_with_rendered_markdown'

class PublishingApiSection
  include ActiveModel::Validations

  validates :to_h, no_dangerous_html_in_text_fields: true

  def initialize(section)
    @manual_slug = section.manual_slug
    @section_id = section.section_id
    @section_attributes = section.section_attributes
  end

  def to_h
    enriched_data = @section_attributes.clone.merge({
      base_path: PublishingApiSection.base_path(@manual_slug, @section_id),
      format: 'hmrc-manual-section',
      publishing_app: 'hmrc-manuals-api',
      rendering_app: 'manuals-frontend',
      routes: [{ path: PublishingApiSection.base_path(@manual_slug, @section_id), type: :exact }]
      })
    enriched_data = StructWithRenderedMarkdown.new(enriched_data).to_h
    enriched_data = add_base_path_to_child_section_groups(enriched_data)
    enriched_data = add_base_path_to_breadcrumbs(enriched_data)
    add_base_path_to_manual(enriched_data)
  end

  def self.base_path(manual_slug, section_id)
    File.join(PublishingApiManual.base_path(manual_slug), section_id)
  end

private
  def add_base_path_to_child_section_groups(attributes)
    # child_section_groups isn't required for sections, so might be nil:
    (attributes["details"]["child_section_groups"] || []).each do |section_group|
      section_group["child_sections"].each do |section|
        section['base_path'] = PublishingApiSection.base_path(@manual_slug, section['section_id'])
      end
    end
    attributes
  end

  def add_base_path_to_breadcrumbs(attributes)
    # breadcrumbs isn't required, so might be nil:
    (attributes["details"]["breadcrumbs"] || []).each do |section|
      section['base_path'] = PublishingApiSection.base_path(@manual_slug, section['section_id'])
    end
    attributes
  end

  def add_base_path_to_manual(attributes)
    attributes["details"]["manual"].delete("slug")
    attributes["details"]["manual"]["base_path"] = PublishingApiManual.base_path(@manual_slug)
    attributes
  end
end