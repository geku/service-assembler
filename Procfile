static:    bundle exec ruby static/static.rb $PORT
service:   bundle exec thin -c ./service/ -p $PORT start
assembler: bundle exec thin -c ./assembler/ -p $PORT start