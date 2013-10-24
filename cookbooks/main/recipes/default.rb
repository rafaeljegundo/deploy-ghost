user node[:user][:name] do
  password node[:user][:password]
  gid "sudo"
  home "/home/#{node[:user][:name]}"
  supports manage_home: true
end

bash "install_node_js" do
  cwd "/usr/src"
  user "root"
  code <<-EOH
    wget http://nodejs.org/dist/v0.10.18/node-v0.10.18.tar.gz
    tar zxf node-v0.10.18.tar.gz
    cd node-v0.10.18
    ./configure
    make
    make install
    EOH
end

package 'unzip'

bash "install_ghost" do
  user "root"
  code <<-EOH
    mkdir /home/deployer/ghost
    cd /home/deployer/ghost
    wget http://ghost.org/zip/ghost-0.3.3.zip
    unzip ghost-0.3.3.zip
    npm -y install --production
    npm install forever -g
    EOH
end

package 'nginx'

template "/etc/nginx/sites-enabled/ghost" do
  source "nginx.erb"
end

bash "start_nginx" do
  user "root"
  code <<-EOH
    sudo /etc/init.d/nginx start
    EOH
end

bash "start_ghost" do
  user "root"
  code <<-EOH
    cd /home/deployer/ghost
    forever start index.js
    EOH
end