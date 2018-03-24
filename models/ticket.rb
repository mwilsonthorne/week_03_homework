require_relative('../db/sql_runner.rb')

class Ticket

attr_reader :id
attr_accessor :film_id, :customer_id

def initialize(identify)
  @id = identify['id'].to_i if identify['id']
  @customer_id = identify['customer_id'].to_i
  @film_id = identify['film_id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def save()
  sql = "INSERT INTO tickets
  (
    customer_id,
    film_id
  )
    VALUES
  (
    $1,$2
  )
  RETURNING id
  "
  values = [@customer_id, @film_id]
  new_id = SqlRunner.run(sql, values).first
  @id = new_id['id'].to_i
end

def self.all()
  sql = "SELECT * FROM tickets"
  arr_hashes = SqlRunner.run(sql)
  arr_obj = arr_hashes.map{|a_hash| Ticket.new(a_hash)}
  return arr_obj
end

def update()
  sql = "UPDATE tickets SET
  (
    customer_id,
    film_id
  )
  =
  (
    $1,$2
  )
  WHERE id = $3
  "
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end


end
