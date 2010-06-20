class AddFormatToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :format, :string, :default => "text/html"
  end

  def self.down
    remove_column :links, :format
  end
end
