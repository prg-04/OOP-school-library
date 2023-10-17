class RentalLister
  def initialize(people)
    @people = people
  end

  def list_rentals_for_person
    if @people.empty?
      puts 'No people available to list rentals.'
      return
    end

    person = select_person_to_list_rentals
    return unless person

    if person.rentals.empty?
      puts "No rentals found for #{person.class.name}: #{person.name} (ID: #{person.id})."
    else
      puts "\nRentals for #{person.class.name}: #{person.name} (ID: #{person.id})"
      list_person_rentals(person)
    end
  end

  private

  def select_person_to_list_rentals
    puts 'Select the person ID to list rentals:'
    list_people
    print 'Enter the person ID: '
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Invalid person ID.'
      return nil
    end

    person
  end

  def list_people
    puts @people.empty? ? 'No people available.' : "\nList of People:\n#{people_list}"
  end

  def people_list
    @people.map.with_index do |person, index|
      "#{index}. [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end.join("\n")
  end

  def list_person_rentals(person)
    person.rentals.each_with_index do |rental, index|
      puts "#{index + 1}. #{rental.book.title}, rented on #{rental.date}"
    end
  end
end