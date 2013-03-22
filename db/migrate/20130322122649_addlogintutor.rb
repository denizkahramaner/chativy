class Addlogintutor < ActiveRecord::Migration
def up
	#for tutors
	add_column :tutors, :login, :string
	Tutor.reset_column_information
	all_tutors = Tutor.find(:all)
	all_tutors.each do |current_tutor|
	    current_tutor.login = current_tutor.last_name.downcase
	    current_tutor.save(:validate => false)
	end
  end

  def down
  	remove_column :tutors, :login
  end
end
