class Blog < ApplicationRecord

  belongs_to :category

  mount_uploader :image, ImageUploader
  mount_uploader :creator_avatar, CreatorAvatarUploader

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

  filterrific(
    default_filter_params: { sorted_by: 'title_asc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_title,
      :with_category_name,
      :with_view_model,
      :with_suggestive
    ]
  )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^title/
      order("LOWER(@blog.title) #{ direction }")
    when /^category_name/
      order("LOWER(blog.category_name) #{ direction }")
    when /^view_model/
      order("LOWER(blog.view_model) #{ direction }")
    when /^suggestive/
      order("LOWER(blog.suggestive) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_category_name, lambda { |category_ids|
    where(category_id: [*category_ids])
  }

  scope :search_query, lambda { |query|
      return nil  if query.blank?
      terms = query.downcase.split(/\s+/)
      terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      num_or_conds = 2
      where(
        terms.map { |term|
          "(LOWER(blog.title) LIKE ? OR LOWER(blog.category_name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
  }

  scope :with_view_model, lambda { |value|
    where('posts.view_model = ?', value)
  }

  scope :with_suggestive, lambda{ |value|
    where('posts.suggestive = ?', value)
  }

  def self.options_for_sorted_by
    [
      ['Title', 'title_asc'],
      ['Category_name', 'category_name_asc'],
      ['View_Model', 'view_model_desc'],
      ['Suggestive', 'suggestive_desc']
    ]
  end

  def create_blog
    @create_blog || self.title || self.category_name || self.creator_name || self.creator_postion || self.creator_old || self.content || self.public_time
  end

  private

  def image_size_validation
    errors[:image] << 'should be less than 2M' if image.size > 2.megabytes
  end
end
