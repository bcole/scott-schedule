class CreateVolunteersAndBlocks < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_number
      t.string :notes

      t.timestamps
    end

    create_table :blocks do |t|
      t.integer :day
      t.integer :start_time

      t.timestamps
    end

    create_table :blocks_volunteers, id:false do |t|
   	  t.belongs_to :block
   	  t.belongs_to :volunteer
    end
  end
end
