# frozen_string_literal: true

# class for QrCode Model
class QrCode < ApplicationRecord
  belongs_to :package

  has_one_attached :image

  validates :base64_string, :package_id, presence: true

  def public_image_url
    if image&.attachment
      if Rails.env.development?
        Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
      else
        image&.service_url&.split('?')&.first
      end
    end
  end
end
