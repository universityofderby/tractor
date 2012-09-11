require 'spec_helper'

module Tractor
    describe Server do
        let(:server){ Tractor::Server.new('nandos','ssh','bob','/var/www/vhosts') }
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
        describe "#revision" do
            it "should send svn info to ssh" do
                ssh.should_receive(:execute).with("svn info").and_return(1)
                server.ssh = ssh
                server.revision
            end
            it "should raise an exception if there is no site" do
                ssh.should_receive(:execute).with("svn info").and_return("not a working copy")
                server.ssh = ssh
                expect { server.revision }.to raise_error("site not found")
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
