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
