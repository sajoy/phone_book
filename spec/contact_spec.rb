require('rspec')
require('contact')


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

  describe("#number") do
    it("returns the number of a contact") do
      new_contact = Contact.new({:name => "Elmo", :number => "1235555432"})
      expect(new_contact.number()).to(eq("1235555432"))
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
