Transform /^(-?\d+)$/ do |number|
      number.to_i
end

Given /^I have not created an application$/ do
end

When /^I create an application called "(.*?)"$/ do |name|
    @app = Tractor::Plough.new(name, 'default_repo')
end

When /^it uses "(.*?)" for the "(.*?)" site$/ do |server, site|
    @app.sites[site].servers << server
end

Then /^a development site should be created on "(.*?)"$/ do |server|
    server = Server.new(server)
    server.has_site('development').should be_true 
end

Then /^a repository should be created$/ do
    @app.repository.should be_true
end

Then /^a development site should be created$/ do 
    @app.sites['development'].should be_true
end

Given /^I have application called "(.*?)"$/ do |name|
    @app = Tractor::Plough.new(name, 'default_repo')
end

Given /^I have a "(.*?)" site at revision (\d+)$/ do |site, revision|
    @app.add_site(site)
    @site = @app.sites[site]
    @site.revision = revision
end

When /^I query the site$/ do 
    @revision = @site.revision
end

Then /^it should be at revision (\d+)$/ do |revision|
    @site.revision.should == revision
end

When /^I update the site to revision (\d+)$/ do |revision|
    @site.update(revision)
end

Then /^all application site servers should be at revision (\d+)$/ do |arg1|
end

Given /^it is at revision (\d+)$/ do |revision|
    @site.revision = revision
end

When /^I rollback the site$/ do
    @site.rollback
end
