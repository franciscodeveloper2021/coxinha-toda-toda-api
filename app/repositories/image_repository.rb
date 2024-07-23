# typed: strict
class ImageRepository
  extend T::Sig

  sig { params(image_request_dto: Requests::ImageRequestDto).void }
  def attach_image(image_request_dto:)
    image = Image.new(
      description: image_request_dto.description,
      imageable: image_request_dto.imageable
    )
    image.content.attach(image_request_dto.content)

    image.save!
  end
end
