class Organisation < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :api_id, presence: true
  validates :web_url, presence: true
  validates :name, presence: true
  validates :organisation_type, presence: true
end
