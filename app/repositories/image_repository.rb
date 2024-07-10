# typed: strict
class ImageRepository
  extend T::Sig

  sig { params(image_request_dto: Requests::ImageRequestDto, imageable: ApplicationRecord).void }
  def attach_image_to_imageable(image_request_dto:, imageable:)
    image = Image.new(
      description: image_request_dto.description,
      imageable: imageable
    )
    image.content.attach(image_request_dto.content)

    image.save!
  end
end
