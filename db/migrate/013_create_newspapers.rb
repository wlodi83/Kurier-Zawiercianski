class CreateNewspapers < ActiveRecord::Migration
  def self.up
    create_table "newspapers", :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.column "name", :string
      t.column "street", :string
      t.column "number", :string
      t.column "city", :string
      t.column "latitude", :float
      t.column "longitude", :float
      t.column "zoom", :float 
    end
  end

  def self.down
    drop_table "newspapers"
  end
end
