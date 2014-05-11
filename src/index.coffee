http    = require 'http'
connect = require 'connect'

nsupdate = require '../vendor/nsupdate'
{passwords, zones, server}  = require './config'

create_command = (zone, ip)->
  """
  server #{zone.server}
  zone #{zone.zone}
  update delete #{zone.hostname}
  update add #{zone.hostname} #{zone.ttl} #{zone.type} #{ip}
  send

  """

app = connect()

app.use connect.basicAuth (user, pass)->
  passwords[user]? and passwords[user] is pass

app.use connect.query()

app.use (req, res)->
  
  data = ''
  zone = zones[req.query.key]

  if not zone?
    res.statusCode = 404
    data = "ERROR: Key not found"
  else if zone.hostname isnt req.query.hostname
    res.statusCode = 404
    data = "ERROR: Hostname doesn't match"
  else if not req.user?
    res.statusCode = 403
    data = "ERROR: Not logged in"
  else if zone.admins.indexOf(req.user) is -1
    res.statusCode = 403
    data = "ERROR: Unauthorized user"
  else
    nsupdate.run req.query.key, create_command(zone, req.connection.remoteAddress ), (error) -> 
      data = error || create_command(zone, req.connection.remoteAddress )

  res.end data

console.log 'server http-to-nsupdate running on: '+ server.port
http.createServer(app).listen(server.port)
