class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  has_attached_file :avatar

  validate :check_type, on: %i[create update]
  do_not_validate_attachment_file_type :avatar

  def check_type
    if attachable_type == 'User'
      errors.add(:avatar_content_type, 'must be an image') unless avatar_content_type =~ %r{/\Aimage\/.*\z/}
    elsif attachable_type == 'Project'
      errors.add(:avatar_content_type, ' (attachment) must be an image or pdf') unless ['application/pdf'].include? avatar_content_type
    end
  end
end
