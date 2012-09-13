Given /^a site has been created with 2 servers$/ do
    site
end

Given /^a site that has been deployed$/ do
    site.status = 'deployed'
end

When /^I query the site$/ do 
    @output = site.query
end

Then /^I should receive information on the site$/ do
    @output.should have_key(:revision)
    @output.should have_key(:servers)
end

Given /^a site that hasn't been deployed$/ do
    site.status = 'undeployed'
end

Then /^I should receive an error$/ do
  pending #@output.should have_key(:error)
end

Given /^a site with servers on different revisions$/ do
    pending("factory girl") {
        site.servers[:server1].revision = 1
        site.servers[:server2].revision = 2
    }
end

Then /^I should receive an inconsistency warning$/ do
  pending #@output.should have_key(:warning)
end

Then /^I should receive information on the differences$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a site doesn't exist$/ do
      pending # express the regexp above with the code you wish you had
end

Then /^I should receive a warning$/ do
      pending # express the regexp above with the code you wish you had
end

def site
    @site ||= Tractor::Site.new
    ssh = double('ssh').as_null_object
    ssh.stub(:execute).with('svn info').and_return(3)
    server1 = build(:server, hostname: "fire", ssh: ssh )
    server2 = build(:server, hostname: "ice", ssh: ssh )
    site = Tractor::Site.new
    site.servers = [server1, server2]
    @site ||= site
end
