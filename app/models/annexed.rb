class Annexed < ApplicationRecord
  belongs_to :examination
  mount_uploader :image, ImageUploader
end
