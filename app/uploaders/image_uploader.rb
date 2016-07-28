class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  

  process :resize_to_fill => [500, -1]
  process :resize_and_pad => [500, 500]

  version :thumb do
    process resize_and_pad: [150, 150]
  end

  def default_url  
    'placeholder.png'
  end

end
