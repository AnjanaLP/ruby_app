# Ruby App

An exercise to implement the requirements given below in order to test functionality,
efficiency, readability and ability to use TDD and OO.

I have test driven the development of four separate classes, Parser, ViewManager, View
and Formatter using the red-green-refactor cycle. I have kept the code DRY, with proper
encapsulation and classes and methods adhere to the Single Responsibility Principle.
I have injected dependencies and provided defaults where appropriate to ensure that the
classes are open for extension but closed for modification.

Unit tests include test doubles and method stubs to effectively isolate the single class
being tested and feature tests check correct integration behaviour between the
classes. Test coverage is 100%.

I feel that the design meets the specified requirements, however if I had more time
I would have considered extracting the file conversion into its own class. Although
I have used a ruby method which is more memory efficient by reading the file
line by line instead of loading them all at once, I should also deal with edge case
scenarios that could arise such as blank lines in the file, more data than expected
on each line, invalid data and not allowing file types which would crash the program
to be passed in as an argument. I would also like to add the capability to read multiple
files at a time and also improve the look of the output generated from running the script.

## Requirements

Write a ruby script that:

a. Receives a log as argument (webserver.log is provided) e.g.: ./parser.rb webserver.log

b. Returns the following:
* list of webpages with most page views ordered from most pages views to less page views e.g.:
/home 90 visits /index 80 visits etc...  
* list of webpages with most unique page views also ordered e.g.:
/about/2 8 unique views /index 5 unique views etc...

## How to use

Clone the repo to your local machine, change into the directory and install the needed gems:
```
$ bundle install
```

To run the test suite:
```
$ bundle exec rspec
```

To run the script from the command line:
```
$ bin/parser webserver.log
```

## Technologies used
- Ruby
- RSpec
- SimpleCov
