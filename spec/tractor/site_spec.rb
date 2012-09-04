require 'spec_helper'

module Tractor
    describe Site do
        let(:server1){ double("Server").as_null_object }
        let(:server2){ double("Server").as_null_object }
        let(:site) { Tractor::Site.new('development',[server1, server2],'deployed') }
        it "has a name" do
            site.name.should == 'development'
        end
        it "has servers" do
            site.servers.should have(2).items
        end     
        it "has a deployment status" do
            site.deployed?.should == true
        end
        describe "#revision" do
            it "should pull revision from server" do
                server1.should_receive(:revision).and_return(3)
                site = Tractor::Site.new('development',[server1])
                site.revision == 3
            end
            it "should pull revision from multiple servers" do
                server1.should_receive(:revision).and_return(3)
                server2.should_receive(:revision).and_return(3)
                site = Tractor::Site.new('development',[server1, server2])
                site.revision == 3
            end
            it "should raise an error if server revisions are different" do
                server1.should_receive(:revision).and_return(2)
                server2.should_receive(:revision).and_return(3)
                site = Tractor::Site.new('development',[server1, server2])
                expect { site.revision }.to raise_error("server revision mismatch")
            end
        end
        describe "#query" do
            it "should return detailed information" do
                server1.stub(:revision).and_return(3)
                server1.stub(:hostname).and_return("server1")
                server2.stub(:revision).and_return(3)
                server2.stub(:hostname).and_return("server2")
                desired_output = {:revision => 3,
                                :status => 'deployed',
                                :servers => ['server1','server2']}
                site.query.should == desired_output
            end
        end
    end
end
