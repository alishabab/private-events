class Event < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :date, presence: true
  validates :description, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: :attended_event_id
  has_many :attendees, through: :invitations

  scope :past, -> { where('date < ?', Date.today) }
  scope :future, -> { where('date >= ?', Date.today) }

  # def self.future
  #   where('date > ?', Date.today)
  # end

  # def self.past
  #   where('date < ?', Date.today)
  # end
end
