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
  @name = params[:id]
  
  @numbers =
  erb(:contact)
end

post('/add_number') do
  type = params['type']
  number = params['number']
  new_number = Contact.new({:type => type, :number => number})
  new_number.save()
  name = params['name']
  redirect('/contact/name')
end
