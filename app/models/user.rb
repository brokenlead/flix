class User < ActiveRecord::Base
    has_secure_password

    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_movies, through: :favorites, source: :movie

    before_save :format_username

    validates :name, presence: true
    validates :email, presence: true,
        format: /\A\S+@\S+\z/,
        uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 3, allow_blank: true }
    validates :username,
        presence: true,
        format: /\A[A-Z0-9]+\z/i,
        uniqueness: { case_sensitive: false }

    scope :by_name, -> { order(:name) }
    scope :not_admins, -> { where(admin: false).by_name }

    def gravatar_id
        Digest::MD5::hexdigest(email.downcase)
    end

    def self.authenticate(login, password)
        user = User.find_by(email: login) || User.find_by(username: login)
        user && user.authenticate(password)
    end

    def to_param
        username
    end

    def format_username
        self.username = username.parameterize
    end
end
