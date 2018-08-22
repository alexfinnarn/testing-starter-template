# Backdrop Testing Starter Kit

Writing tests is important for the success of any Backdrop module. They can help to prevent regressions from bugs as you make PRs and merge in code as well as serve as a spec of what your module should and shouldn't be able to do.

If you ported a module from Drupal 7 to Backdrop, you may already have some tests in your module. Many Drupal 7 contrib modules have SimpleTests in them which were run via the drupal.org test runner.

This starter kit will help you to add Behat and SimpleTests to your contrib module as well as run any SimpleTests already written for your module. The tests will be run via Travis CI and provide advice for integrating with Sauce Labs for Selenium-based tests.
