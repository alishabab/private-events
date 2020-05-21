# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event'
  has_many :invitations, foreign_key: :attendee_id
  has_many :attended_events, through: :invitations

  scope :past, -> { where('date < ?', Date.today) }
  scope :future, -> { where('date >= ?', Date.today) }

  # def upcoming_events
  #   Event.where('date > ?', Date.today)
  # end
  # def previous_events
  #   Event.where('date < ?', Date.today)
  # end
end
