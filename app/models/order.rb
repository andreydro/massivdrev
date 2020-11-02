# frozen_string_literal: true

# class for Order Model
class Order < ApplicationRecord
  has_many :packages

  validates :title, :customer_info, :order_info, presence: true
end
