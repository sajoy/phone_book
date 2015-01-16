require('rspec')
require('contact')
require('phone')

describe(Contact) do

  before() do
   Contact.clear()
  end

  describe("#name") do
    it("returns the name of a contact") do
      new_contact = Contact.new({:name => "Sarah", :number => "5403717951"})
      expect(new_contact.name()).to(eq("Sarah"))
    end
  end

  describe("#id") do
    it("returns the unique id of a contact") do
      new_contact = Contact.new({:name => "Sarah", :number => "5403717951"})
      new_contact2 = Contact.new({:name => "Mother", :number => "5408997951"})
      expect(new_contact.id()).to(eq("S7951"))
      expect(new_contact2.id()).to(eq("M7951"))
    end
  end

  describe("#initial_number") do
    it("will return the inital number entered when a contact is created as a Phone object") do
      new_contact = Contact.new({:name => "Sarah", :number => "5403717951"})
      expect(new_contact.initial_number()).to(be_a(Phone))
    end
  end

  describe("#numbers") do
    it("returns the numbers of a contact") do
      new_contact = Contact.new({:name => "Elmo", :number => "1235555432"})
      new_phone = Phone.new({:number => "0009998888", :type => "work"})
      new_contact.add_phone(new_phone)
      expect(new_contact.numbers()).to(eq([new_contact.initial_number(), new_phone]))
    end
  end

  describe("#add_phone") do
    it("adds a phone to a contact's array of nummbers") do
      new_contact = Contact.new({:name => "Elmo", :number => "1235555432"})
      new_phone = Phone.new({:number => "0009998888", :type => "work"})
      new_contact.add_phone(new_phone)
      expect(new_contact.numbers()).to(eq([new_contact.initial_number(), new_phone]))
    end
  end

  describe("#edit") do
    it("allows you to add a name to a number without one") do
      new_contact = Contact.new({:number => "9876543210"})
      new_contact = new_contact.edit({:name => "The Muffin Man"})
      expect(new_contact.name()).to(eq("The Muffin Man"))
    end

    it("allows you to add a number to a name without one") do
      new_contact = Contact.new({:name => "Mom"})
      new_contact = new_contact.edit({:number => "5403717951"})
      expect(new_contact.numbers()).to(eq([new_contact.initial_number()]))
    end

    it("won't overwrite an exisiting attribute with nil") do
      new_contact = Contact.new({:name => "Mom", :number => "5551234321"})
      new_contact = new_contact.edit({:number => "5403717951"})
      expect(new_contact.numbers()).to(eq([new_contact.initial_number()]))
      expect(new_contact.name()).to(eq("Mom"))
    end

    it("will completely overwrite old attributes if both are present") do
      new_contact = Contact.new({:name => "Dad", :number => "5551234321"})
      new_contact = new_contact.edit({:name => "Mickey Mouse", :number => "5403717951"})
      expect(new_contact.numbers()).to(eq([new_contact.initial_number()]))
      expect(new_contact.name()).to(eq("Mickey Mouse"))
    end
  end

  describe("#delete_phone") do
    it("will remove a Phone from a contact") do
      new_contact = Contact.new({:name => "Tarzan", :number => "1235550987"})
      new_phone = Phone.new({:type => "cell", :number => "9991112345"})
      new_contact.add_phone(new_phone)
      new_contact.delete_phone(new_contact.initial_number())
      expect(new_contact.numbers()).to(eq([new_phone]))
    end
  end

  describe("#delete_contact") do
    it("will remove a contact from the array of all contacts") do
      new_contact = Contact.new({:name => "Random Dude", :number => "5555431209"})
      new_contact2 = Contact.new({:name => "Dave", :number =>"8047867890"})
      new_contact.save()
      new_contact2.save()
      new_contact.delete_contact()
      expect(Contact.all()).to(eq([new_contact2]))
    end
  end

  describe("#save") do
    it("saves the contact to an array") do
      new_contact = Contact.new({:name => "Jenny", :number => "5558675309"})
      new_contact.save()
      expect(Contact.all()).to(eq([new_contact]))
    end
  end

  describe(".all") do
    it("starts empty") do
      expect(Contact.all()).to(eq([]))
    end

    it("returns the list in alphabetical order by first name") do
      new_contact = Contact.new({:name =>"Sarah", :number => "5403717951"})
      new_contact1 = Contact.new({:name =>"Elmo", :number => "1235555432"})
      new_contact.save()
      new_contact1.save()
      expect(Contact.all()).to(eq([new_contact1, new_contact]))
    end
  end

  describe(".clear") do
    it("clears out the array of all contacts") do
      new_contact = Contact.new({:name => "Jenny", :number => "5558675309"})
      new_contact.save()
      Contact.clear()
      expect(Contact.all()).to(eq([]))
    end
  end

end
