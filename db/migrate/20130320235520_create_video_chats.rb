class CreateVideoChats < ActiveRecord::Migration
  def change
    create_table :video_chats do |t|
   		t.column :id, 			:integer
   		t.column :date, 		:timestamp
   		t.column :session_id,	:string
   		t.column :session_token, :string

    	t.timestamps
    end
  end
end
