class { 'akserver':
}

# service {'apache2':
#     ensure => stopped
# }

# class { '::mysql::server':
#     root_password => 'vitannouncements'
# }

# # class {'::mongodb::globals':
# #   manage_package_repo => true,
# # }->
# # class {'::mongodb::server': }->
# # class {'::mongodb::client': }

# # class { 'redis':
# #     redis_max_memory => '256mb'
# # }


# # PHP #
# class { 'php':
#     require => Service['apache2'],
#     service => 'nginx'
# }

# php::module { "fpm": 
# }->
# php::module { "mcrypt": 
# }->
# php::mod { "mcrypt":
#     notify => Service['php5-fpm']
# }

# file { 'custom_php.ini':
#     path => '/etc/php5/fpm/conf.d/custom_php.ini',
#     ensure => present  
# }

# service {'php5-fpm':
#     require => Php::Module['fpm'],
#     ensure => true
# }


# # NGINX #

# $www_root = '/home/vagrant/Code/api/public'

# class { 'nginx': }

# nginx::resource::vhost { 'api.vitannouncements.com':
#     www_root => $www_root
# }

# nginx::resource::location { 'api.vitannouncements.com-location-php':
#     ensure => present,
#     vhost => 'api.vitannouncements.com',
#     www_root => $www_root,
#     location => '~ \.php$',
#     try_files => ['$uri', '$uri/', '/index.php?$query_string', '=404'],
#     fastcgi => 'unix:/var/run/php5-fpm.sock',
#     location_cfg_append => {
#         fastcgi_split_path_info => '^(.+\.php)(/.+)$',
#         fastcgi_index => 'index.php'
#     }
# }

