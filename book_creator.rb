class BookCreator
  def initialize(books)
    @books = books
  end

  def create_book
    print "Enter the book's title: "
    title = gets.chomp
    print "Enter the book's author: "
    author = gets.chomp

    book = Book.new(title, author)
    @books << book

    puts 'Book created successfully!'
  end
end