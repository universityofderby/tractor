require 'spec_helper'

module Tractor
    describe Site do
        let(:server1){ double("Server").as_null_object }
        let(:server2){ double("Server").as_null_object }
        let(:site) { Tractor::Site.new('development',[server1, server2]) }
        it "has a name" do
            site.name.should == 'development'
        end
        it "has servers" do
            site.servers.should have(2).items
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
    end
end
