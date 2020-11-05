# frozen_string_literal: true

# class for Package Model
class Package < ApplicationRecord
  has_one :qr_code
  belongs_to :order, inverse_of: :packages

  enum status: %i[cylindering_shop intermediate_warehouse drying impregnation finished_goods_warehouse shipment]

  validates :order_id, :size, :info, :status, presence: true

  ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"id\", '99999999'), ' ', '', 'g')"
    )
  end

  ransacker :order_id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"order_id\", '99999999'), ' ', '', 'g')"
    )
  end

  ransacker :status, formatter: proc { |v| statuses[v] } do |parent|
    parent.table[:status]
  end

  ransacker :created_at, type: :date do
    Arel.sql('date(created_at)')
  end
end
