class Spree::Slide < ActiveRecord::Base

  has_attached_file :image, styles: { small: "250x250>", medium: "600x600>", large: "1000x1000>", original: "100%" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  scope :published, -> { where(published: true).order('position ASC') }

  belongs_to :product, touch: true

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
      product.images.first.attachment.url
    else
      size = size.try(:downcase)
      size = 'medium' unless %w(small medium large original).include?(size)
      self.image.url(size.to_sym)
    end
  end
end
