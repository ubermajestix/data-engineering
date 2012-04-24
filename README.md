# Hello!
Thanks for considering me for the position of Senior Software Engineer.
I have done my best to quickly write this application to achieve the
goals laid out in the instructions. 

I could have easily fulfilled the requirements by writing procedural
code in a controller but have opted for a more object-oriented design,
and no, that does not mean I moved all the funcationality into the
models.  The code is encapulated into classes that could be easily
extracted out of Rails into their own libraries or services as this app
was required to scale. In my experience this style of programming also
lends itself to handling changing requirements more easily than
untangling a mess of code stashed in Rails helpers or controllers.

I have left lots of comments that should help you understand how I
designed the app. My commit messages can also be a guide to
understanding my development process.

# Setup
You will need:

1. sqlite3
2. redis (for Resque)
3. ruby 1.9.3
4. rails 

Installation instructions provided use the [homebrew](http://mxcl.github.com/homebrew/) 
package manager for OS X. If you are on a Linux environment the process
should be relatively same, just use your favorite package managment tool
like `apt-get` or `yum`.

###Installing sqlite3

    brew install sqlite3

###Installing redis

    brew install redis

###Installing ruby 1.9.3
I use [rvm](http://beginrescueend.com/) to manage ruby versions. There
is a `.rvmrc` file included in the repo. It should install the correct
version of ruby for you and setup your gemset. If you use rbenv, well,
you should know what to do. If you're not using a ruby version manager
you should be. Please check out the link to rvm above for installation
and operating instructions.

###Installing rails (and all gems)
Install bundler if needed
 
    gem install bundler

Bundle install the needed gems, including rails.
    
    cd ~/path/to/this/repo
    bundle install

###Setup the database
This command will create a new database, run the migrations and create
the test database from the generated schema. 

    rake db:create db:migrate db:test:prepare

#Start the app!
The web server and Resque can be started at the same time using Foreman.

    foreman start

#Running the tests

    rake
