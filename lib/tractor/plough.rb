module Tractor
    class Plough
        attr_accessor :sites
        attr_accessor :name
        def initialize(name, sites)
            @name = name
            @sites = sites
        end
    end

    class Site
        attr_accessor :servers
        attr_accessor :name
        
        def initialize(name, servers)
            @name = name
            @servers = servers
        end
        def update(revision)
        end
        def rollback
        end
        def version
            versions = servers.collect{ |server| server.version }
            if versions.uniq.length == 1
                versions
            else
                raise "server version mismatch"
            end
        end
    end

    class Server
        attr_accessor :hostname
        attr_accessor :username
        attr_accessor :basedir
        attr_accessor :ssh

        def initialize(hostname, username, basedir)
            @hostname = hostname
            @username = username
            @basedir = basedir
        end

        def ssh(ssh)
            @ssh = ssh
        end

        def version
            revision = @ssh.execute("svn info")
            raise("site not found") unless revision.is_a?(Numeric)
        end

        def update
            begin
                version
            rescue
                @ssh.execute("svn checkout #{basedir}")
            else
                @ssh.execute("svn update #{basedir}")
            end
        end
    end
end
