# Drupal

## About

This stack installs and serves your drupal installations, easily.

To start with this stack, follow those steps:
- Download drupal and unzip it
- Copy sites/default/default.settings.php to sites/default/settings.php
- Add your database configuration (Sample below)
- Add a random hashsalt (Optional)
- Zip your modified drupal up again (e.g., zip -r MY_PACKAGE.zip *)
- Deploy to cloudbees with those parameters:
    
        bees app:deploy -a MY_APP -t drupal \
        -Ruser='admin' -Rpass='password' -Rname='My awesome site' -Remail='admin@mydomain.com' \
        -RPLUGIN.SRC.drupal='http://cloudbees-clickstack.s3.amazonaws.com/testing/drupal-plugin.zip' \
        -Rprofile='standard' MY_PACKAGE.zip


Then the Stack will install everything for you, and you should land on the Drupal main page, ready to go!

If you wish to reinstall completely, drop the all tables with a MySQL tool (Like MySQL Workbench), or create a new database on CloudBees

## Drupal Database configuration with CloudBees

    # Create an application and database if you didn't do so already
    bees app:create MY_APP
    bees db:create MY_DB

    # Bind them for added CloudBees magic
    bees app:bind -a MY_APP -db MY_DB -as binding 

Then, change your $databases array in settings.php to something like:

    $databases['default']['default'] = array(
        'driver' => 'mysql',
        'database' => getenv('MYSQL_DB_BINDING'),
        'username' => getenv('MYSQL_USERNAME_BINDING'),
        'password' => getenv('MYSQL_PASSWORD_BINDING'),
        'host' => getenv('MYSQL_HOST_BINDING'),
        'prefix' => 'drupal_',
    );

You may of course change the alias 'binding', but make sure that it is in uppercase in the database configuration.

## TODO:

Allowing for double quotes in password