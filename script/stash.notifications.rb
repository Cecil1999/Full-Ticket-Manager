#!/usr/bin/env ruby

require 'pg'

db  = PG.connect(host: "127.0.0.1", port: 5432, dbname: "full_ticket_manager_development", user: "postgres", password: "password")
res = db.exec('SELECT * FROM users')

puts res.values
