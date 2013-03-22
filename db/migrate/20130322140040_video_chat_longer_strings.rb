class VideoChatLongerStrings < ActiveRecord::Migration
  	def up
    	change_column :video_chats, :session_token, :text
    	change_column :video_chats, :session_id, :text
	end
	def down
	    # This might cause trouble if you have strings longer
	    # than 255 characters.
	    change_column :video_chats, :session_id, :string
	    change_column :video_chats, :session_token, :string
	end
end
