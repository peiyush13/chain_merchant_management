class Merchant
  include Mongoid::Document

  field :location, type: String
  field :active, type: Boolean, default: true

  # google info
  field :google_merchant_id, type: String, default: ''
  field :address, type: String, default: ''
  field :open_hours, type: Hash , default: {}
  field :photos, type: Array, default: []
  field :industry, type: String, default: ''
  field :longitude, type: Float
  field :latitude, type: Float

  # associations
  belongs_to :chain

  # @todo add it
  # embeds_many :reviews

  #validations
  validates :chain_id, presence: true, if: Proc.new { |c| c.active }
  validates :location, presence: true, uniqueness: true

  after_create :fetch_details

  def remove_from_chain
    self.chain = nil
    self.active = false
    self.save
  end

  def fetch_details
    client = GooglePlaces::Client.new(GOOGLE_API_KEY)
    spot  = client.spots(latitude, longitude, :name  => self.chain.name)[0].as_json(methods: [:place_id, :lat, :long, :formatted_address,:opening_hours, :photos, :reviews])
    self.update_attributes(google_merchant_id: spot[:place_id], latitude: spot[:lat], longitude: spot[:long], address: spot[:formatted_address], open_hours: spot[:opening_hours], photos: spot[:photos])
  end
end
