plugin_name = drupal-plugin

publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

# Version
lib/drush.zip = drush-5.8.zip

deps = lib php lib/drush.zip

pkg_files = README.md LICENSE setup functions lib php/lib conf  \
			php/php-setup php/conf php/control php/php-functions

include plugin.mk

base_url = http://cloudbees-clickstack.s3.amazonaws.com/lib
parser_repo = git://github.com/benjaminsavoy/genapp-metadata-parser.git
php_repo = git://github.com/CloudBees-community/php-clickstack.git

lib:
	mkdir -p lib

lib/%.zip:
	wget -qO $@ $(base_url)/$($@)

php:
	git clone $(php_repo) php
	rm -rf php/.git*
	mv php/functions php/php-functions
	mv php/setup php/php-setup
	cd php; make deps