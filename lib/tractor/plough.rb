module Tractor
    class Plough
        attr_accessor :sites
        attr_accessor :name
        def initialize(name, sites=Hash.new)
            @name = name
            @sites = sites
        end
    end
end
