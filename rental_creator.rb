class RentalCreator
    def initialize(people, books)
    @people = people
    @books = books
  end
  def create_rental
    if @people.empty? || @books.empty?
      puts 'No people or books available to create a rental.'
      return
    end
    book = select_book_for_rental
    return unless book
    person = select_person_for_rental
    return unless person
    date = input_rental_date
    puts "Date: #{date}, Book: #{book.title}"
    person.add_rental(date, book)
    puts 'Rental created successfully!'
  end
  private
  def select_book_for_rental
    puts 'Select the book for the rental:'
    list_books
    print 'Select a book from the following list by number: '
    book_index = gets.chomp.to_i
    book = @books[book_index]
    if book.nil?
      puts 'Invalid book index.'
      return nil
    end
    book
  end
  def select_person_for_rental
    puts 'Select the person for the rental:'
    list_people
    print 'Select a person from the following list by number (not id): '
    person_index = gets.chomp.to_i
    person = @people[person_index]
    if person.nil?
      puts 'Invalid person index.'
      return nil
    end
    person
  end
  def input_rental_date
    print 'Date (YYYY-MM-DD): '
    gets.chomp
  end
  def list_books
    puts @books.empty? ? 'No books available.' : "\nList of Books:\n#{books_list}"
  end
  def list_people
    puts @people.empty? ? 'No people available.' : "\nList of People:\n#{people_list}"
  end
  def books_list
    @books.map.with_index { |book, index| "#{index}. Title: \"#{book.title}\", Author: #{book.author}" }.join("\n")
  end
  def people_list
    @people.map.with_index do |person, index|
      "#{index}. [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end.join("\n")
  end
end
