Feature: Manage sites 

    Scenario: Create application
        Given I have not created an application
        When I create an application called "example"
        Then a repository should be created

    Scenario: Query the development site version
        Given I have application called "example"
        And I have a "development" site at revision 1
        When I query the site
        Then it should be at revision 1
    
    Scenario: Update the development site
        Given I have application called "example"
        And I have a "development" site at revision 1
        When I update the site to revision 2
        Then it should be at revision 2
    
    Scenario: Rollback the development site
        Given I have application called "example"
        And I have a "development" site at revision 2
        When I rollback the site
        Then it should be at revision 1
