# frozen_string_literal: true

# class for Order Model
class Order < ApplicationRecord
  has_many :packages, inverse_of: :order
  belongs_to :user

  enum status: %i[active archive]

  validates :title, :customer_info, :order_info, :user_id, :status, presence: true

  accepts_nested_attributes_for :packages, reject_if: :all_blank, allow_destroy: true

  ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"id\", '99999999'), ' ', '', 'g')"
    )
  end

  ransacker :status, formatter: proc { |v| statuses[v] } do |parent|
    parent.table[:status]
  end

  ransacker :created_at, type: :date do
    Arel.sql('date(created_at)')
  end
end
