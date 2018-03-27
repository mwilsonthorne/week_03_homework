require_relative('../db/sql_runner.rb')

class Film

attr_reader :id
attr_accessor :title, :price

def initialize(details)
  @id = details['id'].to_i if details['id']
  @title = details['title']
  @price = details['price'].to_i
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def save()
  sql = "INSERT INTO films
  (
    title,
    price
  )
    VALUES
  (
    $1,$2
  )
  RETURNING id
  "
  values = [@title, @price]
  new_id = SqlRunner.run(sql, values).first
  @id = new_id['id'].to_i
end

def self.all()
  sql = "SELECT * FROM films"
  arr_hashes = SqlRunner.run(sql)
  arr_obj = []
  for a_hash in arr_hashes
  # arr_obj = arr_hashes.map{|a_hash| Film.new(a_hash)}
  return arr_obj
  end
end

def update()
  sql = "UPDATE films SET
  (
    title,
    price
  )
  =
  (
    $1,$2
  )
  WHERE id = $3
  "
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def customer()
  sql = "SELECT customers.name FROM customers
        INNER JOIN tickets ON customers.id = tickets.customer_id
        INNER JOIN films ON tickets.film_id = films.id
        WHERE films.title = $1"
  values = [@title]
  arr_hashes = SqlRunner.run(sql, values)
  arr_obj = arr_hashes.map{|a_hash| Film.new(a_hash)}
  return arr_obj
end

def how_many_customer()
  sql = "SELECT tickets.* FROM tickets
  INNER JOIN films ON films.id = tickets.film_id
  WHERE films.title = $1
  "
  values = [@title]
  arr_hashes = SqlRunner.run(sql, values)
  arr_obj = arr_hashes.map{|a_hash| Film.new(a_hash)}
  return arr_obj
end


end
