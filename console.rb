require_relative('models/ticket.rb')
require_relative('models/film.rb')
require_relative('models/customer.rb')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Matthew', 'funds' => 20})
customer1.save()
customer2 = Customer.new({'name' => 'Mark', 'funds' => 30})
customer2.save()
customer3 = Customer.new({'name' => 'Drummond', 'funds' => 100})
customer3.save()

film1 = Film.new({'title' => 'The Untouchables', 'price' => 10})
film1.save()
film2 = Film.new({'title' => 'Falling Down', 'price' => 5})
film2.save()
film3 = Film.new({'title' => 'Blues Brothers', 'price' => 1})
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket3.save()

all_customers = Customer.all()
all_films = Film.all()
all_tickets = Ticket.all()

customer1.name = "Marcelline"
customer1.funds = 50
customer1.update()

film1.title = "Rocky"
film1.price = 2
film1.update()

ticket1.film_id = film3.id
ticket1.customer_id = customer3.id
ticket1.update()

customer1.delete()
ticket1.delete()
film1.delete()

customer3.film()

films = film3.customer()
p films

how_many_tickets = customer3.how_many_ticket()
p how_many_tickets

how_many_customer = film3.how_many_customer()
p how_many_customer

customer3.tickets()
# customer3.remaining_fund()
