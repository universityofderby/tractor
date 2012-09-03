require 'spec_helper'

module Tractor
    describe Site do
        let(:server1){ double("Server").as_null_object }
        let(:server2){ double("Server").as_null_object }
        let(:site) { Tractor::Site.new('development',[server1, server2],false) }
        it "has a name" do
            site.name.should == 'development'
        end
        it "has servers" do
            site.servers.should have(2).items
        end     
        it "has a deployment status" do
            site.deployed.should == false
        end
        describe "#version" do
            it "should pull version from server" do
                server1.should_receive("version").and_return(3)
                site = Tractor::Site.new('development',[server1])
                site.version == 3
            end
            it "should pull version from multiple servers" do
                server1.should_receive("version").and_return(3)
                server2.should_receive("version").and_return(3)
                site = Tractor::Site.new('development',[server1, server2])
                site.version == 3
            end
            it "should raise an error if server versions are different" do
                server1.should_receive("version").and_return(2)
                server2.should_receive("version").and_return(3)
                site = Tractor::Site.new('development',[server1, server2])
                expect { site.version }.to raise_error("server version mismatch")
            end
        end
        describe "#query" do
            it "should return an array" do
                site.query.should be_an_array
            end
            pending("TODO"){
            it "should return detailed information" do
                desired_output = {:version => 1,
                                :status => 'deployed',
                                :servers => ['server1','server2']}
                site.query.should == desired_output
            end}
        end
    end
end
