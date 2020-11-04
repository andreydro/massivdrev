# frozen_string_literal: true

# class for Package Model
class Package < ApplicationRecord
  has_one :qr_code
  belongs_to :order, inverse_of: :packages

  enum status: %i[cylindering_shop intermediate_warehouse drying impregnation finished_goods_warehouse shipment]

  validates :order_id, :size, :info, :status, presence: true
end
