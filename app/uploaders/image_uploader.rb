class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  process :resize_to_limit => [400, 400]
  
  def extension_white_list
    %w(jpg jpeg png)
  end

  include Cloudinary::CarrierWave
end