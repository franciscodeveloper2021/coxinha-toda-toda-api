# typed: true
class Image < ApplicationRecord
  include ValidationConstants

  extend T::Sig

  belongs_to :imageable, polymorphic: true
  has_one_attached :content

  validates :description,
            presence: true,
            length: { maximum: MAXIMUM_DESCRIPTION_LENGTH }

  validates :content,
            attached: true,
            content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
