class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  has_attached_file :avatar

  validate :check_type, on: [:create, :update]
  do_not_validate_attachment_file_type :avatar

  def check_type
    if attachable_type == "User"
      unless avatar_content_type.match(/\Aimage\/.*\z/)  
        errors.add(:avatar_content_type, "must be an image")
      end
    end
  end
end
