class RentalLister
  def initialize(people, rentals)
    @people = people
    @rentals = rentals
  end

  def list_rentals_for_person
    if @people.empty?
      puts 'No people available to list rentals.'
      return
    end

    selected_person = select_person_to_list_rentals
    return unless selected_person

    person_name = selected_person.name

    person_rentals = @rentals.select { |rental| rental.person.name == person_name }

    if person_rentals.empty?
      puts "No rentals found for #{person_name}."
    else
      puts "\nRentals for #{person_name}:"
      list_rentals(person_rentals)
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

  def list_rentals(rentals)
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}"
    end
  end
end
