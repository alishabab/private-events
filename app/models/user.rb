# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_events, foreign_key: 'creator', class_name: 'Event'
  has_many :invitations, foreign_key: :attendee_id
  has_many :attended_events, through: :invitations, source: :attended_event
end
