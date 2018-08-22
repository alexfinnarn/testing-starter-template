#!/usr/bin/env bash

echo "Running Behat headless tests..."
${ROOT_DIR}/backdrop/modules/${MODULE_NAME}/tests/behat/bin/behat --stop-on-failure --strict --config ${ROOT_DIR}/backdrop/modules/${MODULE_NAME}/tests/behat/behat.travis.yml --verbose --tags ${EXPRESS_HEADLESS_BEHAT_TAGS}
earlyexit

echo "Running Behat JS tests..."
${ROOT_DIR}/drupal/profiles/express/tests/behat/bin/behat --stop-on-failure --strict --config ${ROOT_DIR}/drupal/profiles/express/tests/behat/behat.travis.yml --verbose --tags ${EXPRESS_JS_BEHAT_TAGS}
earlyexit

exit 0
