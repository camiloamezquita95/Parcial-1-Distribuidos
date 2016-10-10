execute 'postgresql-repo' do
  command 'sudo rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm'
end

execute 'postgresql-install' do
  command 'sudo yum -y install postgresql95-server.x86_64 postgresql95'
end

execute 'postgresql-initdb' do
  command 'sudo service postgresql-9.5 initdb'
end

execute 'postgresql-onboot' do
  command 'sudo chkconfig postgresql-9.5 on'
end

service "postgresql-9.5" do    
    action [ :enable, :start ]
end

execute 'create-user-admin' do
  command 'useradd -ms /bin/bash admin'
end

cookbook_file "/tmp/create_schema.sql" do
  source "create_schema.sql"
  mode '0777' 
  owner "vagrant"
  group "vagrant"
  action :create
end

bash "create schema" do
	user "root"
	cwd "/tmp"
	code <<-EOH
	cat create_schema.sql | sudo -u postgres psql
	EOH
end

file '/var/lib/pgsql/9.5/data/postgresql.conf' do
  action :delete
end

cookbook_file "/var/lib/pgsql/9.5/data/postgresql.conf" do
	source "postgresql.conf"
	mode '0644'
	owner "postgres"
	group "postgres"
	action :create
end

execute 'trust-access' do
  command 'echo "host all all 192.168.0.0/24 trust" >> /var/lib/pgsql/9.5/data/pg_hba.conf'
  user "root"
end

execute 'restart-postgresql' do
  command 'sudo service postgresql-9.5 restart'
end

bash "open port i" do
	user "root"
	code <<-EOH
	iptables -I INPUT 1 -p tcp -m state --state NEW -m tcp --dport 5432 -j ACCEPT
	service iptables save
	EOH
end

bash "open port o" do
	user "root"
	code <<-EOH
	iptables -I OUTPUT 1 -p tcp -m state --state NEW -m tcp --dport 5432 -j ACCEPT
	service iptables save
	EOH
end



