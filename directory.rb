@students = [] # empty array accessible to\from all methods
@width = 50
def print_menu
  puts '*** MAIN MENU ***'.center(@width)
  puts "1. Add students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1" then input_students
  when "2" then show_students
  when "3" then save_students
  when "4" then load_students
  when "9" then exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the name of a student. To finish, just hit return twice"
  name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_student(name)
    count_students
    #puts "Now we have #{@students.count} students"
    # get another name from the user
    puts "Please enter the name of another student or press enter to choose another option"
    name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
  end
  # return the array of students
  #students
end

def print_header
  puts "The students of Villains Academy".center(@width)
  puts "-------------".center(@width)
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def count_students
  @students.count == 1 ? (puts "We have #{@students.count} great student".center(@width)) : (puts "We have #{@students.count} great students".center(@width))
end

def show_students
  print_header
  print_students_list
  count_students
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

# 14.1
def add_student(name, cohort = :november.capitalize)
  @students << {name: name, cohort: cohort}
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort.to_sym)
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  # 14.2 - start
  # return if filename.nil? # get out of the method if it isn't given
  if filename.nil?
    filename = "students.csv"
  end
  # 14.2 - end
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end
# nothing happens until we call the methods
try_load_students
interactive_menu
