class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.text :long_url
      t.string :token
      t.text :short_url
      t.string :ip_address
      t.integer :domain_id, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
