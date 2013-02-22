plugin_name = drupal-plugin

publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

deps = php lib/drush-5.8.zip

pkg_files = README.md LICENSE setup functions lib conf \
	php/php_functions php/php_setup php/conf php/control php/lib

include plugin.mk

base_url = http://cloudbees-clickstack.s3.amazonaws.com

lib/%.zip:
	mkdir -p lib
	wget -qO $@ $(base_url)/$@

php_core_gitrepo = git://github.com/CloudBees-community/php-clickstack.git

php:
	git clone $(php_core_gitrepo) php
	rm -rf php/.git*
	mv php/functions php/php_functions
	mv php/setup php/php_setup
	cd php; make deps
