require 'csv'

@students = []
@width = 50

@loaded_filename = ""
@default_filename = "students.csv"

def print_menu
  puts '*** MAIN MENU ***'.center(@width)
  puts "1. Add students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    puts "You have selected to enter a student"
    input_students
  when "2"
    puts "You have selected to show the students"
    show_students
  when "3"
    puts "Please enter the name of the file you want to save student data to"
    save_filename = STDIN.gets.chomp
    save_filename.empty? ? save_students : save_students(save_filename)
  when "4"
    puts "Please enter the name of the file you want to load student data from"
    puts "If you leave this field empty, data from students.csv will be loaded"
    load_filename = STDIN.gets.chomp
    load_filename.empty? ? load_students : load_students(load_filename)
  when "9"
    puts "You quit the program successfully"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the name of a student. To finish, just hit return twice"
  name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
  while !name.empty? do
    add_student(name)
    count_students
    puts "Please enter the name of another student or press enter to choose another option"
    name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
  end
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

def add_student(name, cohort = :november.capitalize)
  @students << {name: name, cohort: cohort}
end

def save_students(filename = @default_filename)
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
    @loaded_filename = filename
    puts
    puts "*** Data saved successfully to #{filename} ***"
    puts
  end
end

def load_students(filename = @default_filename)
  @students = []
  if File.exists?(filename)
    CSV.foreach(filename) do |row|
      name, cohort = row
      add_student(name, cohort.to_sym)
    end
    @loaded_filename = filename
    puts
    puts "*** File loaded successfully ***"
    puts "*** Using: #{filename}"
    puts
  elsif filename == @default_filename
    puts "Default file #{@default_filename} not found"
    File.write("students.csv", "")
    @loaded_filename = filename
    puts "Created new #{@default_filename}"
  else
    puts "File #{filename} not found"
    puts "Using #{@loaded_filename}"
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    puts
    puts "Loaded the default file: #{@default_filename}"
    puts
    @loaded_filename = @default_filename
    load_students
    loaded_filename = filename
    load_students(filename)
    return
  end
  if File.exists?(filename)
    loaded_filename = filename
    load_students(filename)
  else
    puts "Sorry, #{filename} not found."
    exit
  end
end
interactive_menu
