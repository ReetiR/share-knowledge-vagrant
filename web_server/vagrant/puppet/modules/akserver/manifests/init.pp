# Class: akserver
#
# This module manages akserver
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage
#
class akserver {

  $domain = 'shareknowledge.com'
  $subdomain = 'api'
  $hostname = "${subdomain}.${domain}"
  $www_root = '/home/vagrant/Code/api/public'
  $mysql_password = 'shareknowledge'


  
  service {'apache2':
    ensure => stopped
  }
  
  class { '::mysql::server':
    root_password => $mysql_password  
  }
  
  # class {'::mongodb::globals':
  #   manage_package_repo => true,
  # }->
  # class {'::mongodb::server': }->
  # class {'::mongodb::client': }
  
  # class { 'redis':
  #     redis_max_memory => '256mb'
  # }
  
  
  # PHP #
  class { 'php':
    require => Service['apache2'],
    service => 'nginx'
  }
  
  php::module { "fpm": 
  }->
  php::module { "mcrypt": 
  }->
  php::mod { "mcrypt":
    notify => Service['php5-fpm'] 
  }
  
  file { 'custom_php.ini':
    path => '/etc/php5/fpm/conf.d/custom_php.ini',
    ensure => present,
    content => template('akserver/custom_php.ini.erb')
  }
  
  service {'php5-fpm':
    require => Php::Module['fpm'],
    ensure => true
  }
  
  
  # NGINX #
  
  class { 'nginx': }
  
  nginx::resource::vhost { $hostname:
    www_root => $www_root,
    index_files => ['index.php', 'index.html', 'index.htm'],
    use_default_location => false
  }

  nginx::resource::location { "${hostname}-location-php":
    ensure => present,
    vhost => $hostname,
    www_root => $www_root,
    location => '~ \.php$',
    try_files => ['$uri', '/index.php', '=404'],
    fastcgi => 'unix:/var/run/php5-fpm.sock',
    location_cfg_append => {
        fastcgi_split_path_info => '^(.+\.php)(/.+)$',
        fastcgi_index => 'index.php'
    },
    include => ['fastcgi_params']
  }->
  nginx::resource::location { "${hostname}-default":
    ensure => present,
    vhost => $hostname,
    www_root => $www_root,
    location => '/',
    index_files => ['index.php', 'index.html', 'index.htm'],
    try_files => ['$uri', '$uri/', '/index.php?$query_string'],
  }
}


