class Addloginstudent < ActiveRecord::Migration
  def up
	#for students
	add_column :students, :login, :string
	Student.reset_column_information
	all_students = Student.find(:all)
	all_students.each do |current_student|
	    current_student.login = current_student.last_name.downcase
	    current_student.save(:validate => false)
	end
  end

  def down
  	remove_column :students, :login
  end
end
