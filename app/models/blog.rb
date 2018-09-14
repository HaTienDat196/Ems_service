class Blog < ApplicationRecord

  belongs_to :category

  mount_uploader :image, ImageUploader
  mount_uploader :creator_avatar, ImageUploader

  validates_integrity_of  :image
  validates_processing_of :image

  validates_integrity_of  :creator_avatar
  validates_processing_of :creator_avatar

  validates :title,    length: { maximum: 255 }, presence: true

  validates :category, presence: true

  validates :creator_name , presence: true, length: {maximum: 32}

  validates :creator_postion , presence: true, length: {maximum: 32}

  validates :creator_old, presence:true, length: {maximum: 2}

  validates :content, presence:true

  validates :public_time, presence:true

  validates :image_url, :format => {
        :with => %r{\.(gif|jpg|png)\Z}i,
        :message => 'Chi nhan file GIF, JPG, PNG'
  }

  validates :creator_avatar_url, :format => {
        :with => %r{\.(gif|jpg|png)\Z}i,
        :message => 'Chi nhan file GIF, JPG, PNG'
  }

  def create_blog
    @create_blog || self.title || self.category_name || self.creator_name || self.creator_postion || self.creator_old || self.content || self.public_time
  end

  private

  def image_size_validation
    errors[:image] << 'should be less than 2M' if image.size > 2.megabytes
  end
end
