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

You can learn more about the Behat project and syntax at the project website: http://behat.org/en/latest/guides.html

## SimpleTests

SimpleTests were the recommended tests to write in Drupal 7 and many contrib modules already have tests in them. SimpleTests aren't as easy to write
as Behat tests, and the syntax is all contained in code making the tests hard to read as well. For these reasons, it is recommended to start writing
tests in Behat rather than SimpleTests. However, there is no reason to not run tests that already exist for your module. 

Also, you may want to test something that doesn't have a custom step definition. The `BackdropUnitTestCase` and `BackdropWebTestCase` classes 
provide a whole slew of useful functions and also allow you to write "unit" tests where you bootstrap less of Backdrop. Most tests you will see are 
written by extending the `BackdropWebTestCase` class and are considered "functional" tests just like Behat.

```php
function testSomethingGood() {
  $body_field = 'body[' . LANGUAGE_NONE . '][0][value]';
  $node = $this->backdropCreateNode(array('status' => FALSE, 'uid' => $this->admin_user->uid));

  // Given I login as...
  $this->backdropLogin($this->admin_user);

  // When I perfom this action...
  $edit = array(
    'title' => 'Test node title',
    $body_field => 'Test node body',
  );
  $this->backdropPost('node/' . $node->nid . '/edit', $edit, t('Save'));

  // Then I see something on the page...
  $this->assertText('Page Test node title has been updated.');
}
```

Each test you write will start with a prefix of `test`. As you can see, the methods used map to writing a Behat test (Given, When, Then), but if I'm
not a developer, it is harder for me to grok what is happening in the test.

## Installation

To install the starter kit in your contrib module:

1. Grab the latest release at...insert final link when repo is transferred.
2a. Create a `tests` directory in your repo, if there isn't one already, and copy in the unzipped files from the release.
2b. If there is a `tests` directory, then look for a `your_module.test` file. If there is one or a similar file, then you likely have SimpleTests 
already written for your module. Hooray! You will still need to modify that file based on 
[converting a module from Drupal documentation](https://api.backdropcms.org/converting-modules-from-drupal). You can delete the `my_module.test` and
`my_module.tests.info` files since the already existing files will take their place and functionality. Copy in all the other files from the unzipped
release files.
4. Rename `example.travis.yml` to `.travis.yml` and place that in the root of your module directory.
3. Change `MODULE_NAME`, `ADD_CUSTOM_MODULES`, and `ADD_CONTRIB_MODULES` to fit your needs. You can modify the `backdrop_test_users` module to add 
local test users with different roles and different permissions. You will typically want to test the permissions granted in your module, but you will
likely need to add Backdrop core permissions to the users. See config files on a live Backdrop site with `user.role.` as a prefix for examples.
4. You can also change `HEADLESS_BEHAT_TAGS` and `JS_BEHAT_TAGS` if you want to target your Behat tests in a different way, but leaving them as-is
will run all of your Behat tests.
5. Enable Travis CI integration on your project's settings page in the GitHub UI. You can read more about that process here: 
https://docs.travis-ci.com/user/getting-started/#to-get-started-with-travis-ci
6. Push up a new PR to your `1.x-` dev branch and see that the Travis test run passes with a green check next to the PR on GitHub.
