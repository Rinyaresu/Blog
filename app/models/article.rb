# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  after_update_commit { broadcast_update }
end
