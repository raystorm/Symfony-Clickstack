# Drupal

## Implementations

If you'd like to test this stack, have a look at the ClickStarts that implement 
it:

####[Openfolio](https://github.com/cloudbees-community/openfolio-clickstart)

## About

This stack installs and serves your drupal installations, easily.

To start with this stack, follow those steps:
- Download drupal and unzip it
- Copy sites/default/default.settings.php to sites/default/settings.php
- Add your database configuration (Sample below)
- Add a random hashsalt (Optional)
- Zip your modified drupal up again (e.g., zip -r MY_PACKAGE.zip .)
- Deploy to cloudbees with those parameters:
    
        bees app:deploy -a MY_APP -t drupal \
        -Ruser='admin' -Rpass='password' -Rname='My awesome site' \
        -Remail='admin@mydomain.com' -Rprofile='standard' \
        -RPLUGIN.SRC.drupal='http://cloudbees-clickstack.s3.amazonaws.com/testing/drupal-plugin.zip' \
        -Rsalt='something_very_random' MY_PACKAGE.zip 


Then the Stack will install everything for you, and you should land on the
Drupal main page, ready to go!

If you wish to reinstall completely, drop the all tables with a MySQL tool (i.e.
MySQL Workbench), or create a new database on CloudBees

## Parameters

#### Installation parameters:

Those parameters will be used only once for installation (Which is triggered if
the DB is empty). As demonstrated above, those runtime parameters are pased
with -Rparam_name='value' with either app:deploy or config:set.

    profile # The profile to use for installation
    name # Administrator account name
    pass # Administrator password
    email # Admininstrator e-mail

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

You may of course change the alias 'binding', but make sure that it is in
uppercase in the database configuration.

## Temporary Directory

It is necessary to add the following line to settings.php, should Drupal need to
use a tmp directory:

    $conf['file_temporary_path'] = getenv('TMPDIR');

## More info

###[PHP ClickStack](https://github.com/cloudbees-community/php-clickstack)

## License

This work is distributed under the Apache license, found in the LICENSE file.