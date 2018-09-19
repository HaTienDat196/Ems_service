class Category < ApplicationRecord
  has_many :blog

  def self.options_for_select
    order('LOWER(category_name)').map { |e| [e.category_name, e.id] }
  end
end
