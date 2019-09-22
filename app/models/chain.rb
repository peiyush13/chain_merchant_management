class Chain
  include Mongoid::Document
  field :name, type: String, default: ''
  field :active, type: Boolean, default: true

  #associations
  has_many :merchants
  validates :name, presence: true
end

