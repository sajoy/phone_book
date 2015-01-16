require('sinatra')
require('sinatra/reloader')
also_reload('/lib/**/*.rb')
require('./lib/contact')
require('./lib/phone')



get('/') do
  @contact_list = Contact.all()
  erb(:index)
end

post('/add_contact') do
  name = params['contact_name']
  number = params['contact_number']
  new_contact = Contact.new({:name => name, :number => number})
  new_contact.save()
  redirect('/')
end

get('/contact/:id') do
  @id = params[:id]
  @contact = Contact.search(@id)
  @name = @contact.name()
  @numbers = @contact.numbers()
  erb(:contact)
end

post('/add_number') do
  @id = params[:id]
  @contact = Contact.search(params['id'])
  type = params['type']
  number = params['number']
  new_number = Phone.new({:type => type, :number => number})
  @contact.add_phone(new_number)
  @name = @contact.name()
  @numbers = @contact.numbers()
  erb(:contact)
end

post('/delete_contact') do
  @id = params[:id]
  @contact = Contact.search(params['id'])
  @contact.delete_contact()
  redirect('/')
end

# post('/edit_number') do
#   @id = params[:id]
#   @contact = Contact.search(params['id'])
#   type = params['type']
#   number = params['number']
#   new_number = Phone.new({:type => type, :number => number})
#   @contact.add_phone(new_number)
#   @name = @contact.name()
#   @numbers = @contact.numbers()
#   erb(:contact)
# end
