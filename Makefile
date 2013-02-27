plugin_name = drupal-plugin

publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

# Version
lib/drush.zip = drush-5.8.zip

deps = lib php lib/drush.zip

pkg_files = README.md LICENSE scripts/* lib conf \
			php/php php/conf php/control php/lib

include plugin.mk

base_url = http://cloudbees-clickstack.s3.amazonaws.com/lib
parser_repo = git://github.com/benjaminsavoy/genapp-metadata-parser.git
php_repo = git://github.com/CloudBees-community/php-clickstack.git

lib:
	mkdir -p lib

lib/parser:
	git clone $(parser_repo) lib/parser

lib/%.zip:
	wget -qO $@ $(base_url)/$($@)

php:
	git clone $(php_repo) php
	rm -rf php/.git*
	mv php/scripts php/php
	cd php; make deps
