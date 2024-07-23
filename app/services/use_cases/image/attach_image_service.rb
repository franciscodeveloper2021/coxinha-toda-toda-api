# typed: strict
module UseCases
  module Image
    class AttachImageService
      extend T::Sig

      sig { params(image_repository: ImageRepository).void }
      def initialize(image_repository:)
        @repository = image_repository
      end

      sig { params(image_request_dto: Requests::ImageRequestDto).void }
      def call(image_request_dto:)
        @repository.attach_image(image_request_dto: image_request_dto)
      end
    end
  end
end
