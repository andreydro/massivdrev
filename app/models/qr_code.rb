# frozen_string_literal: true

# class for QrCode Model
class QrCode < ApplicationRecord
  belongs_to :package

  has_one_attached :image

  def public_image_url
    image_url = nil
    if image&.attachment
      if Rails.env.development?
        image_url = Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
      else
        image_url = image&.service_url&.split('?')&.first
      end
    end
    # set a default lazily
    image_url ||= ActionController::Base.helpers.asset_path('default_company_icon.png')
  end
end
