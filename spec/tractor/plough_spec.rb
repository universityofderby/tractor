require 'spec_helper'

module Tractor
    describe Plough do
        let(:site) { double("Site").as_null_object }
        let(:plough) { Tractor::Plough.new('example',[site]) }
        it "has a name" do
            plough.name.should == 'example'
        end
        it "has sites" do
            plough.sites.should have(1).items
        end
        describe "#config" do
            it "should load applications from a configuration" do
                pending { plough.load_config("config.yaml") }
            end
        end
    end
end
