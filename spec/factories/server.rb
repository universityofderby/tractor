FactoryGirl.define do
    factory :server, class: Tractor::Server do
        hostname "server1"
        username "bob"
        basedir "/var/www/vhosts"
    end
end
