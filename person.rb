class Person

    attr_accessor :name, :age

    def initialize(name="Unknown", parent_permission=true, age)
        @id = Random.rand(1..1000)
        @name = name
        @age = age
    end
    
    def can_use_services?
        @parent_permission || of_age?(@age)
    end
    
    private

    def of_age?(age)
        age >= 18
    end
    

end

