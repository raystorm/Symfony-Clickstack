plugin_name = drupal-plugin
publish_bucket = cloudbees-clickstack
publish_repo = testing
publish_url = s3://$(publish_bucket)/$(publish_repo)/

base_url = http://cloudbees-clickstack.s3.amazonaws.com

deps = php lib/drush-5.8.zip

pkg_files = LICENSE setup functions lib php

include plugin.mk

lib/%.zip:
	mkdir -p lib
	wget -qO $@ $(base_url)/$@

php_core_gitrepo = git://github.com/benjaminsavoy/php-core.git

php:
	git clone $(php_core_gitrepo) php
	cd php; make