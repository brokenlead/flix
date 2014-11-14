class Genre < ActiveRecord::Base
    has_many :characterizations, dependent: :destroy
    has_many :movies, through: :characterizations
    
    before_validation :generate_slug

    validates :name, presence: true, uniqueness: true
    validates :slug, uniqueness: true

    def generate_slug
        self.slug ||= name.parameterize if name
    end

    def to_param
        slug
    end
end
