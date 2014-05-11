http-to-nsupdate
================

A http request entry point to handle ``nsupdate`` tool remotely via http ``GET`` requests. Use-full to make a remote dns update from an reduced soft/hard device - like routers - where you don't have an ssh console, or a full web client.

The **nsupdate bash** ``vendor/nsupdate.js`` invoked from the web server, was taken from [nsupdate-proxy](https://github.com/unhosted/nsupdate-proxy) project **owned by** [unhosted](https://github.com/unhosted), thanks!

Requisites
--

* Know how to setup DDNS on your DNS **bind9** server see [ddns with bind9](https://www.erianna.com/nsupdate-dynamic-dns-updates-with-bind9).
* Basic nodejs and coffee knowledge.

Installation
--
* git clone from your fork of [http-to-nsupdate](https://github.com/eerrecart/http-to-nsupdate) or download the source.
* setup ``config.coffee`` based on ``config.sample.coffee``
   
  ```
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
  ```
  * `` user : 'pass' `` your basic auth credentials.
  * ``"askldhasjkldh=="`` the **TSIG keys** used on bind9 to allow updates on the zone: ``zone      : 'example.com.'``
  * ``hostname  : 'subdomain.example.com'`` subdomain to update.
  
* run the ``index.coffee`` / ``index.js``

Test
--
* ``curl --user user:pass "http://your_web_host:8080/?key=key_name:key&hostname=subdomain.example.com"``
    *  ``--user user:pass`` the basic auth credentials on ``config.coffee``
    * key: the key name/ key value pair **URL ENCODED** i.e:
        * if generated key is: ``Kexample.com.+127+24536.private `` the name is: ``example.com``
        * combined with the key value: ``example.com:z4PhNX7vuL3xVChQ1m2AB9Yg5AULVxXcg/SpIdNs6c5H0NE8XYXysP+DGNKHfuwvY7kxvUdBeoGlODJ6+SfaPg==`` (remember to encode it).
    * hostname: ``subdomain.example.com`` host to update.

Related links
--

* Based on [nsupdate-proxy](https://github.com/unhosted/nsupdate-proxy)
* DNS server side config followed from **Charles Portwood**: [blog - erianna](https://www.erianna.com/nsupdate-dynamic-dns-updates-with-bind9)

-----
**Thanks** to [fcingolani](https://github.com/fcingolani) for the **emotional-spiritual** support.