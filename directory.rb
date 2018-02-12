#8.6
@width = 50
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
    students << {name: name, cohort: more_info[:cohort], hobbies: more_info[:hobbies],
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

def info()
  months = ["january", "february", "march", "april", "may", "june", "july",
                    "august", "september", "october", "november", "december"]
  puts "Enter your cohort"
  cohort = gets.chomp
  while !months.include? cohort.downcase || cohort != "" do
    puts "Please enter a valid month"
    cohort = gets.chomp
  end
  if cohort == ""
    cohort = :february
end
  puts "Enter the student's hobbies separated by a comma"
  hobbies = gets.chomp
  puts "Enter the student's country of origin"
  country = gets.chomp.capitalize
  puts "Enter the student's height"
  height = gets.chomp.to_i
  return {cohort: cohort.downcase.to_sym, hobbies: hobbies, country: country, height: height}
end

def print_header
puts "The students of Villains Academy".center(@width)
puts "-------------".center(@width)
end

def print(students)
  students.each do |student|
    puts "Name: #{student[:name]} | Cohort: #{student[:cohort]} | Hobbies: #{student[:hobbies]} | Country of origin: #{student[:country]} | Height: #{student[:height]}".center(@width)
  end
end

#8.4
def print_with_loop(students)
  x = 0
  while x < students.count
    puts "#{students[x][:name]} (#{students[x][:cohort]})".center(@width)
    x += 1
  end
end

#8.3
def print_by_name_length(students)
  puts "Names with maximum length of (please enter a number):".center(@width)
  max_length = gets.chomp
  matching_students = 0
  students.each do |student|
    if student[:name].length <= max_length.to_i
      puts "#{student[:name]} (#{student[:cohort]} cohort)".center(@width)
      matching_students += 1
    else
    end
  end
  puts
  puts "There are #{matching_students} students whose maximum name's length is #{max_length} characters.".center(@width)
  puts
end

#8.2
def print_specific_first_letter(students)
  puts "Student names beginning with: (Please enter a letter)".center(@width)
  letter = gets.chomp
  matching_students = 0
  students.each do |student|
    if student[:name].start_with?(letter.upcase, letter.downcase)
      puts "#{student[:name]} (#{student[:cohort]} cohort)".center(@width)
      matching_students += 1
    else
    end
  end
  puts
  puts "#{matching_students} students' name begins with #{letter}".center(@width)
  puts
end

#8.1
def print_number_before(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(@width)
  end
end


def print_footer(students)
puts "Overall, we have #{students.count} great students".center(@width)
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
