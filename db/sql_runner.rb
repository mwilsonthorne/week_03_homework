require('pg')

class SqlRunner

  def self.run( sql, values = [])
    db = PG.connect({dbname: 'codeclan_cinema',
      host: 'localhost'  })


    db.prepare("save", sql)
    result =  db.exec_prepared("save", values)

    db.close()

    return result
  end


end
