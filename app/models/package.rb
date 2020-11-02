# frozen_string_literal: true

# class for Package Model
class Package < ApplicationRecord
  has_one :qr_code

  validates :order_id, :size, :info, presence: true
end
