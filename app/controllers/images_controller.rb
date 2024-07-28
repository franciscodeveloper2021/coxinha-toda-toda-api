# typed: strict
class ImagesController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @attach_image_service = T.let(UseCases::Image::AttachImageService.new, UseCases::Image::AttachImageService)
  end

  sig { void }
  def create
    
  end

  private

  sig { returns(ActionController::Parameters) }
  def permitted_params
    params.require(:image).permit(:description, :content, :imageable_type, :imageable_id)
  end

  sig { returns(Requests::ImageRequestDto) }
  def image_params
    permitted = permitted_params

    Requests::ImageRequestDto.new(
      description: permitted[:description],
      imageable: find_imageable(permitted[:imageable_type], permitted[:imageable_id]),
      content: permitted[:content]
    )
  end

  sig { params(type: String, id: Integer).returns(ApplicationRecord) }
  def find_imageable(type, id)
    type.constantize.find(id)
  end
end
