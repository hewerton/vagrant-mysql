exec {'apt-update':
    command => '/usr/bin/apt-get update'
}

package {'nginx':
    ensure => installed,
    require => Exec['apt-update']
}

# We want MySQL installed on our machine
# We want MySQL to be constantly running
class { '::mysql::server':
    # We want to set custom MySQL root password
    root_password    => 'root',
    override_options => {
        'mysqld' => {
            # We want MySQL max connections to be set to max_connections
            'max_connections'   => '1024',
            # We want MySQL key_buffer_size set to 512M      
            'key_buffer_size'   => '512M'       
        }       
    }   
}
