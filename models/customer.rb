require_relative('../db/sql_runner.rb')

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize( details )
  @id = details['id'].to_i if details['id']
  @name = details['name']
  @funds = details['funds'].to_i
end


def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

def save()
  sql = "INSERT INTO customers
    (
      name,
      funds
    )
      VALUES
    (
      $1,$2
    )
    RETURNING id
    "
  values = [@name, @funds]
  new_id = SqlRunner.run(sql, values).first
  @id = new_id['id'].to_i
end

def self.all()
  sql = "SELECT * FROM customers"
  arr_hashes = SqlRunner.run(sql)
  # arr_obj = arr_hashes.map{|a_hash| Customer.new(a_hash)}
  arr_obj = []
  for a_hash in arr_hashes
  return arr_obj
  end
end

def update()
  sql = "UPDATE customers SET
  (
    name,
    funds
  )
  =
  (
    $1,$2
  )
  WHERE id=$3
  "
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM customers
  WHERE id=$1
  "
  values = [@id]
  SqlRunner.run(sql, values)
end

def film()
  sql = "SELECT films.title FROM films
         INNER JOIN tickets ON films.id = tickets.film_id
         INNER JOIN customers ON tickets.customer_id = customers.id
         WHERE customers.name = $1"
  values = [@name]
  arr_hashes = SqlRunner.run(sql, values)
  arr_obj = arr_hashes.map{|a_hash| Customer.new(a_hash)}
  return arr_obj
end

def how_many_ticket()
  sql = "SELECT tickets.* from tickets INNER JOIN customers
  ON customers.id = tickets.customer_id
  WHERE customers.name = $1"
  values = [@name]
  arr_hashes = SqlRunner.run(sql, values)
  arr_obj = arr_hashes.map{|a_hash| Customer.new(a_hash)}
  return arr_obj
end

def tickets()
  sql = "SELECT * FROM tickets WHERE customer_id = $1"
  values = [@id]
  arr_hashes = SqlRunner.run(sql, values)
  arr_obj = arr_hashes.map{|a_hash| Ticket.new(a_hash)}
end

# def remaining_fund()
#   films = self.tickets()
#   film_price = films.map{|film| Film.new(film)}
#   total_price = film_price.sum
#   return @funds - total_price
# end

end
