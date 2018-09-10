class Blog < ApplicationRecord

  belongs_to :category

  mount_uploader :image, ImageUploader
  mount_uploader :avatar, ImageUploader

  # validates_integrity_of  :image
  # validates_processing_of :image
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

  # validates :title,    length: { maximum: 255 }, presence: true

  # validates :category, presence: true

  # validates :category, presence: true

  # validates :creator_name , presence: true, length: {maximum: 32}

  # validates :creator_postion , presence: true, length: {maximum: 32}

  # validates :creator_old, presence:true, length: {maximum: 2}

  # private

  # def avatar_size_validation
  #   errors[:avatar] << 'should be less than 2M' if avatar.size > 2.megabytes
  # end
end
