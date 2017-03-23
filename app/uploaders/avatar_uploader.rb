class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'https://placeholdit.imgix.net/~text?txtsize=33&txt=140%C3%97100&w=140&h=100'
  end

  # Process files as they are uploaded:
  process scale: [150, 150]
  #
  def scale(width, height)
    resize_to_fill width, height
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [360, 200]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{mounted_as}.jpg" if original_filename
  end

end
