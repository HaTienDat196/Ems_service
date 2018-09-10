class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [20, 20]
  end

  version :medium do
    process resize_to_fill: [60, 60]
  end

  version :small do
    process resize_to_fill: [70, 70]
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
