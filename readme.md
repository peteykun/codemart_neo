# CodeMart Neo

This is a web app to host a coding competition that allows buying and selling of code snippets.

* Has a full-featured admin panel.

* Features Google Code Jam-like program testing, with runtime input and output generation.

# Installation

Please run the database migrations and seed the database. For Rails 4, the following should suffice.

    $ rake db:reset

Running in `development` mode requires MySQL, while `production` is configured for Heroku. Set environmental variables for `database.yml` in order to run in development, or deploy to heroku directly.
