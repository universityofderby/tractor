require 'spec_helper'

module Tractor
    describe Plough do
        it "can have sites" do
        pending("TODO"){    
            plough = Tractor::Plough.new('example')
        }
        end
    end
    describe Site do
        let(:server1){ double("Server").as_null_object }
        let(:server2){ double("Server").as_null_object }
        let(:site) { Tractor::Site.new('development',3,[server1, server2]) }
        it "has a name" do
            site.name.should == 'development'
        end
        it "has a revision" do
            site.revision.should be_an_integer
        end
        it "has servers" do
            site.servers.should have(2).items
        end     
        describe "#version" do
            it "should pull version from server" do
                server1.should_receive("version").and_return(3)
                site = Tractor::Site.new('development',3,[server1])
                site.version == 3
            end
            it "should pull version from multiple servers" do
                server1.should_receive("version").and_return(3)
                server2.should_receive("version").and_return(3)
                site = Tractor::Site.new('development',3,[server1, server2])
                site.version == 3
            end
            it "should raise an error if server versions are different" do
                server1.should_receive("version").and_return(2)
                server2.should_receive("version").and_return(3)
                site = Tractor::Site.new('development',3,[server1, server2])
                expect { site.version }.to raise_error("server version mismatch")
            end
        end
    end
    describe Server do
        let(:server){ Tractor::Server.new('nandos','bob','/var/www/vhosts') }
        let(:ssh){ double("ssh").as_null_object }
        it "has a hostname" do
            server.hostname.should == 'nandos'
        end
        it "has a username" do
            server.username.should == 'bob'
        end
        it "has a base directory" do
            server.basedir.should == '/var/www/vhosts'
        end
        describe "#version" do
            it "should send svn info to ssh" do
                ssh.should_receive(:execute).with("svn info").and_return(1)
                server.ssh = ssh
                server.version
            end
            it "should raise an exception if there is no site" do
                ssh.should_receive(:execute).with("svn info").and_return("not a working copy")
                server.ssh = ssh
                expect { server.version }.to raise_error("site not found")
            end
        end

        describe "#update" do
            it "should send svn checkout to ssh if there is no site" do
                ssh.should_receive(:execute).with("svn info").and_return("not a working copy")
                ssh.should_receive(:execute).with("svn checkout /var/www/vhosts")
                server.ssh = ssh
                server.update
            end
            it "should send svn update to ssh if site is present" do
                ssh.should_receive(:execute).with("svn info").and_return(1)
                ssh.should_receive(:execute).with("svn update /var/www/vhosts")
                server.ssh = ssh
                server.update
            end
        end
    end
end
