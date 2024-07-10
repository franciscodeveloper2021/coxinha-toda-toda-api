# typed: strict
module Requests
  class ImageRequestDto < T::Struct
    const :description, String
    const :content, ActionDispatch::Http::UploadedFile
  end
end
