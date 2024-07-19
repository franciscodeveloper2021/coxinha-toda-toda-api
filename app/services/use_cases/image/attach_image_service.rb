# typed: strict
module UseCases
  module Image
    class AttachImageService
      extend T::Sig

      sig { params(image_repository: ImageRepository).void }
      def initialize(image_repository:)
        @repository = image_repository
      end
    end
  end
end
