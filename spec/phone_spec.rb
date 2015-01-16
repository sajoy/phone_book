require('rspec')
require('phone')
require('contact')

describe(Phone) do

  describe("#type") do
    it("returns the type of phone") do
      new_contact = Contact.new({:name => "Jenny", :number => "5558675309"})
      new_contact.save()
      new_number = Phone.new({:type => "home", :number => ""})

    end
  end



end
