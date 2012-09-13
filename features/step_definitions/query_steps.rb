Given /^a site has been created with 2 servers$/ do
    server1 = build_server("fire", 3)
    server2 = build_server("ice", 3)
    site.servers = [server1, server2]
end

Given /^a site that has been deployed$/ do
    site.status = 'deployed'
end

When /^I query the site$/ do 
    @output = lambda { site.query }
end

Then /^I should receive information on the site$/ do
    @output.call.should have_key(:revision)
    @output.call.should have_key(:servers)
end

Given /^a site that hasn't been deployed$/ do
    site.status = 'undeployed'
end

Then /^I should receive an error$/ do
    expect {@output.call}.to raise_error
end

Given /^a site with servers on different revisions$/ do
    server1 = build_server("fire", 2)
    server2 = build_server("ice", 3)
    site.servers = [server1, server2]
end

Then /^I should receive an inconsistency warning$/ do
    expect {@output.call}.to raise_error
end

Then /^I should receive information on the differences$/ do
    pending # express the regexp above with the code you wish you had
end

def site
    @site ||= build(:site)
end

def build_server(name, revision)
    ssh = double('ssh').as_null_object
    ssh.stub(:execute).with('svn info').and_return(revision)
    build(:server, hostname: name, ssh: ssh )
end
