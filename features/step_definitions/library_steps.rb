Given /^I have not created application "(.*?)"$/ do |arg1|
end

When /^I create application "(.*?)"$/ do |application|
    @app = Tractor.new(application)
end

Then /^an "(.*?)" repository should be created$/ do |application|
    @app.repository should be true
end

Then /^an "(.*?)" development site should be created$/ do |application|
    @app.sites.development should be true
end

When /^I update "(.*?)" development site$/ do |arg1|
    @app.sites.development.update()
end

Then /^the site should be deployed to "(.*?)" and "(.*?)"$/ do |server1, server2|
    @app.sites.development.server1.deployed? should be true
    @app.sites.development.server2.deployed? should be true
end

Then /^the site should be at revision "(.*?)"$/ do |revision|
    @app.sites.development.version should be "HEAD"
end

When /^I query "(.*?)" development$/ do |arg1|
    output = @app.sites.development.version
end

Then /^I should receive information on the site from all servers$/ do
    output should contain server1
    output should contrain server2
end

