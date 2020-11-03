# frozen_string_literal: true

# class for Order Model
class Order < ApplicationRecord
  has_many :packages, inverse_of: :order

  validates :title, :customer_info, :order_info, presence: true

  accepts_nested_attributes_for :packages, reject_if: :all_blank, allow_destroy: true
end
