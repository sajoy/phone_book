require('rspec')
require('phone')
require('contact')

describe(Phone) do

  describe("#initialize") do
    it("allows only one attribute to be added") do
      new_number = Phone.new({:type => "home"})
      newer_number = Phone.new({:number => "9876543210"})
      expect(new_number.type()).to(eq("home"))
      expect(newer_number.number()).to(eq("9876543210"))
    end
  end

  describe("#number") do
    it("returns the phone's number") do
      new_number = Phone.new({:type => "work", :number => "5555431234"})
      expect(new_number.number()).to(eq("5555431234"))
    end
  end

  describe("#type") do
    it("returns the type of phone") do
      new_number = Phone.new({:type => "home", :number => "5552138866"})
      new_contact = Contact.new({:name => "Ernie", :number => "9990123455"})
      expect(new_number.type()).to(eq("home"))
      expect(new_contact.initial_number().type()).to(eq(nil))
    end
  end

  describe("#edit") do
    it("allows you to add a type to a Phone without one") do
      new_number = Phone.new({:number => "9876543210"})
      new_number = new_number.edit({:type => "work"})
      expect(new_number.type()).to(eq("work"))
    end

    it("allows you to add a number to a Phone without one") do
      new_number = Phone.new({:type => "cell"})
      new_number = new_number.edit({:number => "5403717951"})
      expect(new_number.number()).to(eq("5403717951"))
    end

    it("won't overwrite an exisiting attribute with nil") do
      new_number = Phone.new({:type => "cell", :number => "5551234321"})
      new_number = new_number.edit({:number => "5403717951"})
      expect(new_number.number()).to(eq("5403717951"))
      expect(new_number.type()).to(eq("cell"))
    end

    it("will completely overwrite old attributes if both are present") do
      new_number = Phone.new({:type => "cell", :number => "5551234321"})
      new_number = new_number.edit({:type => "home", :number => "5403717951"})
      expect(new_number.number()).to(eq("5403717951"))
      expect(new_number.type()).to(eq("home"))
    end

  end


end
