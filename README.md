# Backdrop Testing Starter Kit

Writing tests is important for the success of any Backdrop module. They can help to prevent regressions from bugs as you make PRs and merge in code as 
well as serve as a spec of what your module should and shouldn't be able to do.

If you ported a module from Drupal 7 to Backdrop, you may already have some tests in your module. Many Drupal 7 contrib modules have SimpleTests in 
them which were run via the drupal.org test runner.

This starter kit will help you to add Behat and SimpleTests to your contrib module as well as run any SimpleTests already written for your module. 
The tests will be run via Travis CI and provide advice for integrating with Sauce Labs for Selenium-based tests.

## Behat Tests

Behat is a testing framework that allows you to write tests in Gherkin syntax that are executed via PHP code. Each "step definition" maps to a PHP
function in a Given, When, Then order. Here is an example Behat test located in the `behat/features/my_feature.feature` file.

```gherkin
@example
Feature: Developer can access admin pages.
  As a developer
  When I login
  I need to be able to access configuration pages.

  Scenario: Access links on admin/config page.
    Given I am logged in as a user with the "developer" role
    When I go to "/admin/config"
    Then I should see "Logging and errors"
    And I should see "Maintenance mode"
```

As you can see, the agile methodology fits in well to writing Behat tests. You generally do something as a user and assert that something you expected
to happen has happened. If the user can see that text, which proves they can access the page, then the test succeeded. If the user gets a 404, then
the test would fail.

You can learn more about the Behat project and syntax 
