#8.5
def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp.capitalize

  if !name.empty?
    more_info = info
  end
  # while the name is not empty, repeat this code
  while !name.empty? do
  # add the student hash to the array
    students << {name: name, cohort: :november, hobbies: more_info[:hobbies],
                 country: more_info[:country], height: more_info[:height]}
    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Please enter the name of another student"
    name = gets.chomp.capitalize
    if !name.empty?
      more_info = info
    end
  end
  # return the array of students
  students
end

def info
  puts "Enter the student's hobbies separated by a comma"
  hobbies = gets.chomp
  puts "Enter the student's country of origin"
  country = gets.chomp.capitalize
  puts "Enter the student's height"
  height = gets.chomp.to_i
  return {hobbies: hobbies, country: country, height: height}
end

def print_header
puts "The students of Villains Academy"
puts "-------------"
end

def print(students)
  students.each do |student|
    puts "Name: #{student[:name]} | Cohort: #{student[:cohort]} | Hobbies: #{student[:hobbies]} | Country of origin: #{student[:country]} | Height: #{student[:height]}"
  end
end

#8.4
def print_with_loop(students)
  x = 0
  while x < students.count
    puts "#{students[x][:name]} (#{students[x][:cohort]})"
    x += 1
  end
end

#8.3
def print_by_name_length(students)
  puts "Names with maximum length of (please enter a number):"
  max_length = gets.chomp
  matching_students = 0
  students.each do |student|
    if student[:name].length <= max_length.to_i
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
      matching_students += 1
    else
    end
  end
  puts
  puts "There are #{matching_students} students whose maximum name's length is #{max_length} characters."
  puts
end

#8.2
def print_specific_first_letter(students)
  puts "Student names beginning with: (Please enter a letter)"
  letter = gets.chomp
  matching_students = 0
  students.each do |student|
    if student[:name].start_with?(letter.upcase, letter.downcase)
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
      matching_students += 1
    else
    end
  end
  puts
  puts "#{matching_students} students' name begins with #{letter}"
  puts
end

#8.1
def print_number_before(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end


def print_footer(students)
puts "Overall, we have #{students.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
