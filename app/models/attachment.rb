class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attachment :storage => :file_system,
                 :path_prefix => 'public/files',
                 :resize_to => '640x480',
                 :thumbnails => { :thumb => '120x80', :window => '80>', :tiny => '50>', :scroll => [419, 282], :scroll_thumb => [60, 40], :display_thumb => [215, 120]},
                 :max_size => 5.megabytes,
                 :content_type => :image,
                 :processor => 'Rmagick'
end
