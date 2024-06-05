# typed: strict
module UseCases
  module Sector
    class DestroySectorService
      extend T::Sig

      sig { params(sector_repository: SectorRepository).void }
      def initialize(sector_repository = SectorRepository.new)
        @repository = sector_repository
      end

      sig { params(id: Integer).void }
      def call(id:)
        @repository.destroy(id: id)
      end
    end
  end
end
