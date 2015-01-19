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

get('/number/:number_id/:contact_id') do
  @number_id = params[:number_id]
  @contact = Contact.search(params[:contact_id])
  @number_to_edit = @contact.search_numbers(@number_id)
  @name = @contact.name()
  erb(:number)
end

post('/delete_number') do
  @number_id = params[:number_id]
  @contact_id = params[:contact_id]
  @contact = Contact.search(@contact_id)
  @number_to_delete = @contact.search_numbers(@number_id)
  @contact.delete_phone(@number_to_delete)
  @numbers = @contact.numbers()
  @id = @contact_id
  erb(:contact)
end

post('/edit_number') do
  @number_id = params[:number_id]
  @contact_id = params[:contact_id]
  @contact = Contact.search(@contact_id)
  @number_to_edit = @contact.search_numbers(@number_id)
  type = params['type']
  number = params['number']
  @old_number_to_delete = @number_to_edit
  @number_to_edit = @number_to_edit.edit({:type => type, :number => number})
  @contact.delete_phone(@old_number_to_delete)
  @contact.add_phone(@number_to_edit)
  @name = @contact.name()
  @numbers = @contact.numbers()
  erb(:number)
end
