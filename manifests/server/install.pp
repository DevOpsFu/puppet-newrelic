class newrelic::server::install ($license_key) {
    include newrelic::repo

    package {'newrelic-sysmond':
        ensure => $newrelic::service_present,
        require => Class['newrelic::repo'],
        notify => Exec['nrsysmond-config-license']
    }
    
    exec { 'nrsysmond-config-license':
        command => "nrsysmond-config --set license_key=${license_key}",
        path => ['/bin', '/usr/bin', '/usr/sbin'],
        notify => Service['newrelic-sysmond'],
        refreshonly => true
        onlyif => $service_present == 'present'
    }
    Package['newrelic-sysmond'] -> Exec['nrsysmond-config-license']
}
