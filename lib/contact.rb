class Contact

  @@all_contacts = []

  attr_reader(:name, :initial_number)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @numbers = []
    @initial_number = Phone.new({:number => attributes[:number]})
    @numbers.push(@initial_number)
  end

  define_method(:id) do
    letter = name().split("")
    numbers = initial_number().number().split("").reverse()

    6.times() do
      numbers.pop()
    end
    numbers = numbers.reverse()
    numbers.insert(0, letter.at(0))
    numbers.join()

  end

  define_method(:search_numbers) do |id|
    found = nil
    @numbers.each() do |number|
      if number.id().==(id)
        found = number
      end
    end
    found
  end

  define_singleton_method(:search) do |id|
    found = nil
    @@all_contacts.each() do |contact|
      if contact.id().==(id)
        found = contact
      end
    end
    found
  end

  define_method(:numbers) do
    @numbers
  end

  define_method(:add_phone) do |phone|
    @numbers.push(phone)
  end

  define_method(:edit) do |attributes|
    old = {:number => numbers(), :name => name()}
    if attributes[:number].==(nil)
      edit = {:name => attributes[:name]}
    elsif attributes[:name].==(nil)
      edit = {:number => attributes[:number]}
    else
      edit = {:name => attributes[:name], :number => attributes[:number]}
    end
    Contact.new(old.merge(edit))
  end

  define_method(:delete_phone) do |phone|
    @numbers.each() do |number|
      if number.type().==(phone.type()).&(number.number().==(phone.number()))
        @numbers.delete(number)
      end
    end
  end

  define_method(:delete_contact) do
    @@all_contacts.each() do |contact|
      if contact.name().==(name()).&(contact.numbers().==(numbers()))
        @@all_contacts.delete(contact)
      end
    end
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
