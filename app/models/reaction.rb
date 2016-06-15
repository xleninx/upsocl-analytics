class Reaction < ActiveRecord::Base
   mount_uploader :avatar, AvatarReactionUploader
end
