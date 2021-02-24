class Spree::Slide < ActiveRecord::Base

  has_attached_file :image, styles: { small: "250x250>", medium: "600x600>", large: "1000x1000>", original: "100%" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  scope :published, -> { where(published: true).order('position ASC') }

  scope :for_group_id, ->(id) { where(slide_group_id: id) }
  scope :for_group, ->(name) { where(slide_group_id: SpreeSlider.group_id_for_name(name) ) }

  validates :slide_group_id, presence: true


  belongs_to :product, touch: true, optional: true

  def initialize(attrs = nil)
    attrs ||= {:published => true}
    super
  end

  def slide_name
    self.name.blank? && product.present? ? product.name : self.name
  end

  def slide_link
    link_url.blank? && product.present? ? product : link_url
  end

  def image_url(size = 'medium')
    if !self.image.file? && product.present? && product.images.any?
      product.images.first.attachment.try(:url) || product.images.first.attachment.try(:service_url)
      # product.images.first&.url(size.to_sym)
    else
      size = size.try(:downcase)
      size = 'medium' unless %w(small medium large original).include?(size)
      self.image.url(size.to_sym)
    end
  end


  def slider_group
    @slider_group ||= SpreeSlider.slide_groups.find{ |g| g[:id] == self.slide_group_id } if self.slide_group_id
  end

  def group_name
    slider_group ? slider_group[:name] : nil
  end

  def group_text
    slider_group ? slider_group[:text] : nil
  end

end
