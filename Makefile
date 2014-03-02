plugin_name = symfony-plugin

publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

pkg_files = README.md LICENSE setup functions lib php/lib conf control modules \
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
	mv php/functions php/php-functions
	mv php/setup php/php-setup
	cd php; make deps
