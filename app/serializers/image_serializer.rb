# typed: true
class ImageSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_url

  extend T::Sig

  sig { returns((String)) }
  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(object.content) if object.content.attached?
  end
end
