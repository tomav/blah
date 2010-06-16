class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :name
      t.boolean :is_default, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
