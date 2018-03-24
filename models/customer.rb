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
  arr_obj = arr_hashes.map{|a_hash| Customer.new(a_hash)}
  return arr_obj
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




end
