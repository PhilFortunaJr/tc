class Product < ApplicationRecord

  has_many :orders
  has_many :comments
  validates :name, presence: true

  def self.search(search_term)
    search_verb = Rails.env.production? ? 'ilike' : 'LIKE'
    Product.where("name #{search_verb} ? OR description #{search_verb} ?", "%#{search_term}%", "%#{search_term}%")
  end

  def highest_rating_comment
    comments.rating_desc.first
  end

  def lowest_rating_comment
    comments.rating_desc.last
  end

  def average_rating
    comments.average(:rating).to_f
  end
end
