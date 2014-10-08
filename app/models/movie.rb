class Movie < ActiveRecord::Base

  has_many :reviews, dependent: :destroy

  has_attached_file :image, styles: {
    small: "90x133>",
    thumb: "50x50"
  }

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, presence: true
  validates :description, length: {minimum: 25}
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}
  validates :rating, inclusion: {in: RATINGS}
  validates_attachment :image,
    :content_type => { :content_type => ['image/jpeg', 'image/png']},
    :size => { :less_than => 1.megabyte}

  def self.released
    where("released_on <= ?", Time.now).order("released_on desc")
  end
  
  def self.hits
    where('total_gross >= 300000000').order('total_gross desc')
  end
  
  def self.flops
    where('total_gross < 10000000').order('total_gross asc')
  end
  
  def self.recently_added
    order('created_at desc').limit(3)
  end
  
  def flop?
    if has_reviews?
      total_gross.blank? || (total_gross < 50000000 && reviews.count <= 50 && average < 4.0)
    else
      total_gross.blank? || total_gross < 50000000
    end
  end

  def average
    reviews.average(:stars)
  end

  def has_reviews?
    not reviews.count.zero?
  end
end
