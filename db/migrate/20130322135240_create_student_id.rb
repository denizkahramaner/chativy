class CreateStudentId < ActiveRecord::Migration
  def up
	#for tutors
	add_column :video_chats, :student_id, :integer
	VideoChat.reset_column_information
  end

  def down
  	remove_column :tutors, :login
  end
end
