Transform /^(-?\d+)$/ do |number|
      number.to_i
end

Given /^a site has been created$/ do
  @site = Tractor::Site.new
end

Given /^a site that has been deployed$/ do
    @site.deployed = true
end

When /^I query the site$/ do 
  @output = @site.query
end

Then /^I should receive information on the site$/ do
    @output.should have_key(:version)
    @output.should have_key(:servers)
end

Given /^a site that hasn't been deployed$/ do
    @site.deployed = false
end

Then /^I should receive an error$/ do
  pending #@output.should have_key(:error)
end

Given /^a site with servers on different revisions$/ do
  @site.servers[:server1].revision = 1
  @site.servers[:server2].revision = 2
end

Then /^I should receive an inconsistency warning$/ do
  pending #@output.should have_key(:warning)
end

Then /^I should receive information on the differences$/ do
  pending # express the regexp above with the code you wish you had
end

