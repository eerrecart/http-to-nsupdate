module.exports =
  server:
    port: 8080
  passwords:
    user : 'pass'
  zones:
    "askldhasjkldh==" :
      hostname  : 'subdomain.example.com'
      server    : 'ns1.example.com'
      zone      : 'example.com.'
      ttl       : '60'
      type      : 'A'
      admins    : [ 'user']