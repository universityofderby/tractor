class Server
    attr_accessor :hostname
    attr_accessor :username
    attr_accessor :basedir
    attr_accessor :ssh

    def initialize(hostname, ssh, username, basedir='/var/www/vhosts')
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

