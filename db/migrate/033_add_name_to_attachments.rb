class AddNameToAttachments < ActiveRecord::Migration
 def self.up
    add_column :attachments, :name, :string, :limit => 500
 end

  def self.down
    remove_column :attachments, :name
  end
end
