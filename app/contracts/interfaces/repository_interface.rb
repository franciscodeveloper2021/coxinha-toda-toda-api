# typed: strict
module Interfaces
  class RepositoryInterface
    extend T::Sig

    sig { abstract.returns(T::Array[T.untyped]) }
    def index; end

    sig { abstract.params(id: Integer).returns(T.untyped) }
    def show(id:); end

    sig { abstract.params(create_params: T.untyped).returns(T.untyped) }
    def create(create_params:); end

    sig { abstract.params(id: Integer, update_params: T.untyped).returns(T.untyped) }
    def update(id:, update_params:); end

    sig { abstract.params(id: Integer).void }
    def destroy(id:); end
  end
end
