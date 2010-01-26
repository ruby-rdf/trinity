Trinity
=======

This is a minimalistic web framework for publishing [Linked
Data](http://linkeddata.org/).

* <http://github.com/datagraph/trinity>

Usage
-----
To start up a Trinity server on <http://localhost:3000/>, invoke the
installed `trinity` program with an RDF input file describing the resources
to publish. An example N-Triples file is included as `etc/localhost.nt`:

    % trinity etc/localhost.nt
    >> Thin web server (v1.2.5 codename This Is Not A Web Server)
    >> Debugging ON
    >> Maximum connections set to 1024
    >> Listening on 0.0.0.0:3000, CTRL+C to stop
    127.0.0.1 - - [15/Jan/2010 22:33:44] "GET /hello HTTP/1.1" 200

Hints
-----
Since [RDF.rb](http://rdf.rubyforge.org/) currently only supports the
N-Triples serialization format, make sure that the input file to Trinity is
in that format.

You can convert RDF/XML to N-Triples with the
[`rapper`](http://librdf.org/raptor/rapper.html) utility:

    % rapper -i rdfxml -o ntriples input.rdf > output.nt

You can convert Turtle to N-Triples as follows:

    % rapper -i turtle -o ntriples input.ttl > output.nt

Documentation
-------------

* <http://trinity.datagraph.org/>

Dependencies
------------

* [RDF.rb](http://gemcutter.org/gems/rdf) (>= 0.0.8)
* [Addressable](http://gemcutter.org/gems/addressable) (>= 2.1.1)
* [Mime::Types](http://gemcutter.org/gems/mime-types) (>= 1.16)
* [Rack](http://gemcutter.org/gems/rack) (>= 1.1.0)
* [Thin](http://gemcutter.org/gems/thin) (>= 1.2.5)
* [Markaby](http://gemcutter.org/gems/markaby) (>= 0.5)

Installation
------------

The recommended installation method is via RubyGems. To install the latest
official release from Gemcutter, do:

    % [sudo] gem install trinity

Download
--------

To get a local working copy of the development repository, do:

    % git clone git://github.com/datagraph/trinity.git

Alternatively, you can download the latest development version as a tarball
as follows:

    % wget http://github.com/datagraph/trinity/tarball/master

Resources
---------

* <http://trinity.datagraph.org/>
* <http://github.com/datagraph/trinity>
* <http://gemcutter.org/gems/trinity>
* <http://raa.ruby-lang.org/project/trinity/>
* <http://www.ohloh.net/p/trinity>

Authors
-------

* [Arto Bendiken](mailto:arto.bendiken@gmail.com) - <http://ar.to/>
* [Josh Huckabee](mailto:joshhuckabee@gmail.com) - <http://joshhuckabee.com/>
* [Ben Lavender](mailto:blavender@gmail.com) - <http://bhuga.net/>

License
-------

Trinity is free and unencumbered public domain software. For more
information, see <http://unlicense.org/> or the accompanying UNLICENSE file.
