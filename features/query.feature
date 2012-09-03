Feature: Query site 
In order to support the sites
As an administrator
I want to find detailed information on deployed sites
    Background: Site created
        Given a site has been created

    Scenario: Query a deployed site
        Given a site that has been deployed
        When I query the site
        Then I should receive information on the site

    Scenario: Query an undeployed site
        Given a site that hasn't been deployed
        When I query the site
        Then I should receive an error

    Scenario: Query site with inconsistent servers
        Given a site with servers on different revisions
        When I query the site
        Then I should receive an inconsistency warning
        And I should receive information on the differences

