class Contact

  @@all_contacts = []

  attr_reader(:name, :number)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @number = attributes[:number]
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
