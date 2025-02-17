# typed: strict
module Requests
  class ImageRequestDto < T::Struct
    const :description, String
    const :imageable, ApplicationRecord
    const :content, ActionDispatch::Http::UploadedFile
  end
end
