module Tractor
    class Server
        attr_accessor :hostname
        attr_accessor :username
        attr_accessor :basedir
        attr_accessor :ssh

        def revision
            cmd_result = @ssh.execute("svn info")
            raise("site not found") unless cmd_result.is_a?(Numeric)
            cmd_result
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
