execute 'install-python' do 
  command 'yum install -y python'
end

execute 'install gcc' do 
  command 'yum install -y gcc'
end

execute 'install postgresql-devel' do 
  command 'yum install -y python-devel postgresql-devel'
end

execute 'change-to-root' do
  command 'sudo su'
end

execute 'get-pip' do 
  command 'wget https://bootstrap.pypa.io/get-pip.py'
end

execute 'install-pip' do 
  command 'python get-pip.py'
end


execute 'install-virtualenv' do
  command 'pip install virtualenv'
end

execute 'create-user-flask' do
  command 'useradd -ms /bin/bash flask'
end

execute 'create-virtualenv' do
  command 'virtualenv flask_env'
  cwd '/home/flask'
  user 'flask'
end

directory '/home/flask/smartlabs' do
  owner 'flask'
  group 'flask'
  mode '0755'
  action :create
end

cookbook_file "/home/flask/smartlabs/requirements.txt" do
	source "requirements.txt"
	mode 0644
	owner "flask"
	group "flask"
end

cookbook_file "/home/flask/smartlabs/myselect.py" do
  source "myselect.py"
  mode 0644
  owner "flask"
  group "flask"
end

cookbook_file "/home/flask/smartlabs/script.sh" do
  source "script.sh"
  mode 0777
  owner "flask"
  group "flask"
end

execute 'run-service-onboot' do
  command 'echo "sh /home/flask/smartlabs/script.sh" >> /etc/rc.local'
  user 'root'
end

bash "open port" do
	user "root"
	code <<-EOH
	iptables -I INPUT 1 -p tcp -m state --state NEW -m tcp --dport 5000 -j ACCEPT
	service iptables save
	EOH
end

execute 'activate-virtualenv' do
  command 'sh /home/flask/smartlabs/script.sh'
  user 'root'
end



