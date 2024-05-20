# typed: strict
module UseCases
  module Sector
    class IndexSectorsService
      extend T::Sig

      sig { params(sector_repository: SectorRepository).void }
      def initialize(sector_repository = SectorRepository.new)
        @repository = sector_repository
      end

      sig { returns(T::Array[Responses::SectorResponseDto]) }
      def index
        @repository.index
      end
    end
  end
end
