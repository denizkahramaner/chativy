class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
		t.column :id, 			:integer
		t.column :first_name, 	:string
	 	t.column :last_name , 	:string
	 	t.timestamps
    end
  end
end
