class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :link_id
      t.text :ip_address
      t.text :referer
      t.text :browser

      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
