# typed: strict
module UseCases
  module Sector
    class ShowSectorService
      extend T::Sig

      sig { params(sector_repository: SectorRepository).void }
      def initialize(sector_repository = SectorRepository.new)
        @repository = sector_repository
      end

      sig { params(id: Integer).returns(Responses::SectorResponseDto) }
      def call(id:)
        @repository.show(id: id)
      end
    end
  end
end
