class Addpasswordstudent < ActiveRecord::Migration
  def up

    add_column :students, :password_digest, :string
    add_column :students, :salt, :string
    Student.reset_column_information
    all_students = Student.find(:all)
    all_students.each do |current_student|
        salt = Random.rand.to_s
        current_student.password_digest = Digest::SHA1.hexdigest(current_student.last_name + salt.to_s)
        current_student.salt = salt
        #current_student.update_attribute(:salt => salt)
        current_student.save(:validate => false)
    end
  end

  def down
    remove_column :students, :password_digest
    remove_column :students, :salt
  end
end
