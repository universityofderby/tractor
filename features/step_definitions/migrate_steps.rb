Given /^there is a revision in development$/ do
    development = site
    server1 = build_server("john",1)
    server2 = build_server("dave",1)
    development.servers = [server1, server2]
    development.revision.should == 1
end

When /^I migrate the revision to test$/ do
    pending{    
        development.migrate_to test
    }
end

Then /^the test site should have the same revision$/ do
    pending # express the regexp above with the code you wish you had
end
