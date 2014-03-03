# Service Assembler

Attempt to assemble multiple data sources into one HTML document with a proxy and multiple sources. Current implementation takes a static HTML page with template tags in it. The assembler proxies the static page and replaces the template tags with content fetched from one or multiple services that return rendered HTML partials of dynamic data. 

In progress and not useful in production right now.

## Get Up and Running

Checkout the source and run 

    bundle install
    foreman start

Afterwards open

    http://localhost:5200

to see the final page assembled by the proxy.

    # Static raw page
    http://localhost:5000

    # Data service (return an HTML partial)
    http://localhost:5100/employees

## License

MIT License. Copyright © 2014 Georg Kunz.
