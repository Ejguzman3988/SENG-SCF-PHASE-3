# require is like an import statement except it loads all methods from the required file (not just the default export)

# require pry so we can use binding.pry within our code
require "pry"
# require "require_all" so we're able to load all files in the
# lib directory all at once
require "require_all"

require "colorize"

require "date"
require "active_support/core_ext/integer/time"
require "active_support/core_ext/date/calculations"

# When we use `require_all`, the path we pass to it will be 
# relative to the root path of the project (where the Gemfile 
# is). In our case, we're loading all of the files inside of 
# the lib directory, so if we write code in there (like a 
# method) it will be accessible to us after the require_all
# below
require_all "lib" #HERE

# add a method that will reload the lib/dog.rb file so we can 
# interact with the most recent version without restarting the console
def reload!
    load "lib/dog.rb"
    load "lib/dogs.rb"
    load "lib/dog_walker_cli.rb"
end

def clear 
    system('clear')
end