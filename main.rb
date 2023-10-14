#!/usr/bin/env ruby


require './app'

def main
  app = App.new

  loop do
    puts "Welcome to the Library Management System"
    puts "Choose an option:"
    puts "1. List all books"
    puts "2. List all people"
    puts "3. Create a person"
    puts "4. Create a book"
    puts "5. Create a rental"
    puts "6. List rentals for a person"
    puts "7. Quit"

    choice = gets.chomp.to_i

    case choice
    when 1
      app.list_all_books
    when 2
      app.list_all_people
    when 3
      print "Enter age: "
      age = gets.chomp.to_i
      print "Enter name (default: Unknown): "
      name = gets.chomp
      print "Does the person have parent permission (true/false, default: true): "
      parent_permission = gets.chomp.downcase == 'false' ? false : true
      app.create_person(age, name, parent_permission: parent_permission)
    when 4
      print "Enter title: "
      title = gets.chomp
      print "Enter author: "
      author = gets.chomp
      app.create_book(title, author)
    when 5
      print "Enter person ID: "
      person_id = gets.chomp.to_i
      print "Enter book title: "
      book_title = gets.chomp
      print "Enter rental date: "
      date = gets.chomp
      app.create_rental(person_id, book_title, date)
    when 6
      print "Enter person ID: "
      person_id = gets.chomp.to_i
      app.list_rentals_for_person(person_id)
    when 7
      puts "Goodbye!"
      break
    else
      puts "Invalid option. Please choose a valid option."
    end
  end
end

main
