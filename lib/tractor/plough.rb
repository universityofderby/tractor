module Tractor
    class Plough
        attr_accessor :sites
        attr_accessor :name
        def initialize(name, sites=Hash.new)
            @name = name
            @sites = sites
        end
    end

    class Site
        attr_accessor :servers
        attr_accessor :name
        attr_accessor :status
        
        def initialize(name='default', servers=Hash.new, status=false)
            @name = name
            @servers = servers
            @status = status
        end
        def revision
            revisions = servers.collect{ |server| server.revision }
            if revisions.uniq.one?
                revisions.first
            else
                raise "server revision mismatch #{revisions}"
            end
        end
        def query
            {   
                :revision => revision,
                :status => @status,
                :servers => @servers.collect{ |server| server.hostname }
            } 
        end
        def deployed?
            @status == 'deployed' 
        end
    end

    class Server
        attr_accessor :hostname
        attr_accessor :username
        attr_accessor :basedir
        attr_accessor :ssh

        def initialize(hostname, ssh, username=hostname, basedir='/var/www/vhosts')
            @hostname = hostname
            @username = username
            @basedir = basedir
            @ssh = ssh
        end

        def revision
            cmd_result = @ssh.execute("svn info")
            raise("site not found") unless cmd_result.is_a?(Numeric)
        end

        def update
            begin
                revision
            rescue
                @ssh.execute("svn checkout #{basedir}")
            else
                @ssh.execute("svn update #{basedir}")
            end
        end
    end
end
