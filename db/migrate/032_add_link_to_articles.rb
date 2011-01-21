class AddLinkToArticles < ActiveRecord::Migration
 def self.up
    add_column :articles, :link, :string, :limit => 300, :null => false

  end

  def self.down
    remove_column :articles, :link
  end
end
