module Tractor
    class Site
        attr_accessor :name
        attr_accessor :servers
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
            raise "undeployed" unless deployed?
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
end
