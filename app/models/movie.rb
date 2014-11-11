class Movie < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

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

  scope :released, -> { where("released_on <= ?", Time.now).order("released_on desc") }
  scope :hits, -> { released.where('total_gross >= 300000000').order('total_gross desc') }
  scope :flops, -> { released.where('total_gross < 50000000').order('total_gross asc') }
  scope :recently_added, -> { order('created_at desc').limit(3) }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on desc") }
  scope :rated, ->(rating="G") { released.where("rating = ?", rating)}
  scope :recent, ->(max=5) { released.limit(max)}
  scope :grossed_less_than, ->(amount) { released.where('total_gross < ?', amount).order("total_gross desc")}
  scope :grossed_greater_than, ->(amount) { released.where('total_gross > ?', amount).order("total_gross")}
  
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
