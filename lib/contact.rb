class Contact

  @@all_contacts = []

  attr_reader(:name, :initial_number)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @numbers = []
    @initial_number = Phone.new({:number => attributes[:number]})
    @numbers.push(initial_number)
  end

  define_method(:numbers) do
    @numbers
  end

  define_method(:add_phone) do |phone|
    @numbers.push(phone)
  end

  define_method(:save) do
    @@all_contacts.push(self)
  end

  define_singleton_method(:all) do
    @@all_contacts =  @@all_contacts.sort_by{|contact| contact.name }
  end

  define_singleton_method(:clear) do
    @@all_contacts = []
  end

end
