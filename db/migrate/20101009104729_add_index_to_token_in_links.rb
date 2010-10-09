class AddIndexToTokenInLinks < ActiveRecord::Migration
  def self.up
    add_index :links, :token, :unique => true
  end

  def self.down
    remove_index :links, :column => :token
  end
end
