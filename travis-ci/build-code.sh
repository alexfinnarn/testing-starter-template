#!/usr/bin/env bash

# Install latest Drush 8.
composer global require "drush/drush:8.*"
export PATH="$HOME/.composer/vendor/bin:$PATH"

mkdir -p ~/.drush/commands
cd ~/.drush/commands

# Need to use special runserver command branch.
git clone --branch alex-test https://github.com/alexfinnarn/drush.git backdrop

# Build Behat dependencies.
cd ${ROOT_DIR}/${MODULE_NAME}/tests/behat
composer install --prefer-dist --no-interaction
earlyexit

# Build Codebase.
cd $ROOT_DIR
echo "Cloning Backdrop repo..."
git clone --branch 1.x --depth 1 https://github.com/backdrop/backdrop.git ${ROOT_DIR}/backdrop

cp -R ${ROOT_DIR}/${MODULE_NAME} ${ROOT_DIR}/backdrop/modules

# Setup files? Does this need to happen in Backdrop?
#mkdir -p $ROOT_DIR/drupal/sites/default/files/styles/preview/public/gallery/ && chmod -R 777 $ROOT_DIR/drupal/sites
#mkdir $ROOT_DIR/tmp && chmod -R 777 $ROOT_DIR/tmp

exit 0
