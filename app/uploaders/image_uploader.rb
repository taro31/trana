class ImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::RMagick
  include Cloudinary::CarrierWave
  
  def size_range
    1..9.megabytes
  end
  
  process :resize_to_limit => [400, 400]
  
  def extension_white_list
    %w(jpg jpeg png)
  end

end