#!/usr/bin/env bash

run() {
  check_running_as_root
  install_dev_group_and_epel§
  install_rvm
  install_ruby
  install_rails
  add_rvm_group_to_cerberus
  install_node
  install_passenger
  install_nginx
  setup_logrotate
  set_rails_env
  install_pwgen
  set_secret_key_base
}

check_running_as_root() {
  if [[ $(id -u) -ne 0 ]]; then
    echo 'Please run as root' >&2
    exit 1
  fi
}

install_dev_group_and_epel() {
  yum -y update
  yum groupinstall -y 'development tools'
  sudo su -c 'rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
  yum -y update
  yum install -y curl-devel sqlite-devel libyaml-devel git vim
}

install_rvm() {
  # rhn-setup needed for rvn dependency on rhn-channel command
  yum -y install rhn-setup
  # setting -E to fix the proxy settings
  curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -
  curl -sSL https://get.rvm.io | sudo -E bash -s stable
  source /etc/profile.d/rvm.sh rvm requirements
  source /etc/profile.d/rvm.sh rvm rvmrc warning ignore all.rvmrcs
}

install_ruby() {
  rvm install 2.2.1
  rvm --default use 2.2.1
  gem install bundler --no-ri --no-rdoc
}

install_rails() {
  gem install bundler rails
}

add_rvm_group_to_cerberus() {
  usermod -aG rvm cerberus
}

install_node() {
  curl -sL https://rpm.nodesource.com/setup | bash -
  yum install -y nodejs
}

install_passenger() {
  gem install passenger -v 5.0.9
}

install_nginx() {
  # curl-config install
  yum -y install libcurl-devel
  passenger-install-nginx-module --auto --languages ruby
  curl -o /etc/rc.d/init.d/nginx https://gitlab.nat.bt.com/radius/mna_controller/raw/master/setup/nginx_control_script.sh
  chmod +x /etc/rc.d/init.d/nginx

  curl -o /opt/nginx/conf/nginx.conf https://gitlab.nat.bt.com/radius/mna_controller/raw/master/setup/nginx.conf
  service nginx start
  chkconfig nginx on
}

setup_logrotate() {
  curl -o /etc/logrotate.d/nginx https://gitlab.nat.bt.com/radius/mna_controller/raw/master/setup/logrotate.d/nginx
  curl -o /etc/logrotate.d/mna_controller https://gitlab.nat.bt.com/radius/mna_controller/raw/master/setup/logrotate.d/mna_controller
}

set_rails_env() {
  su cerberus <<EOF
cat <<Yml >> /home/cerberus/.bash_profile
export RAILS_ENV=production
Yml
EOF
}

install_pwgen() {
  curl -O http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  rpm -Uvh epel-release-6*.rpm
  yum -y install pwgen
}

set_secret_key_base() {
  su cerberus <<'EOF'
cat <<YMl >> /home/cerberus/.bash_profile
export SECRET_KEY_BASE=$(pwgen -s 128 1)
YMl
EOF
source /home/cerberus/.bash_profile
}

run
