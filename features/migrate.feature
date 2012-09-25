Feature: Migrate site 
In order to get a new feature
As an administrator
I want to move a revision between sites
    Scenario: Migrate a revision between development and test 
        Given there is a revision in development
        When I migrate the revision to test
        Then the test site should have the same revision 
