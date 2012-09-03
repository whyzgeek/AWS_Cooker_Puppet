class apache2 {
    package { 'apache2':
        ensure  => installed,
    }

    file { '/etc/apache2/apache2.conf':
        ensure  => file,
        content => template("apache2/apache2.conf"),
        require => Package['apache2'],
        notify  => Service['apache2'],
    }

    file { '/var/www/':
        ensure  => directory,
        source  => '/etc/puppet/private/www',
        recurse => true,
        require => Package['apache2'],
        before  => Service['apache2'],
    }

    service { 'apache2':
        ensure  => running,
        enable  => true,
    }
}
