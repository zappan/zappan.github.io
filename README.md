# Working on site

You will need ruby and bundler for the site. Edit stuff in content and layouts folders.

This will live compile on every change:

    $ cd _site
    $ gem install bundler
    $ bundle install
    $ guard

You should serve it from the output folder, simplest way is with the python simple http server:

    $ cd _site
    $ cd output
    $ python -m SimpleHTTPServer

When you're done with changes compile site:

    $ cd _site
    $ rake wczg:compile

This will compile the site and copy everything in the right place.

Now you can add files with git and push to github