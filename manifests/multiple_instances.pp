class { '::tomcat': }
class { '::java': }

#Install Multiple instances of tomcat

##First Instance of tomcat
tomcat::instance { 'tomcat':
  catalina_base => '/opt/tomcat',
  source_url    => 'http://mirror.nexcess.net/apache/tomcat/tomcat-8/v8.0.8/bin/apache-tomcat-8.0.8.tar.gz',
}
-> tomcat::service { 'default':
  catalina_base => '/opt/tomcat',
}

##Second Instance of tomcat

tomcat::instance { 'tomcat1':
  catalina_base => '/opt/tomcat1',
  source_url    => 'http://mirror.nexcess.net/apache/tomcat/tomcat-8/v8.0.8/bin/apache-tomcat-8.0.8.tar.gz',
}
-> tomcat::config::server { 'tomcat1':
  catalina_base => '/opt/tomcat1',
  port          => '8105',
}
-> tomcat::config::server::connector { 'tomcat1-http':
  catalina_base         => '/opt/tomcat1',
  port                  => '8180',
  protocol              => 'HTTP/1.1',
  additional_attributes => {
    'redirectPort' => '8543',
  },
}
-> tomcat::config::server::connector { 'tomcat1-ajp':
  catalina_base         => '/opt/tomcat1',
  port                  => '8109',
  protocol              => 'AJP/1.3',
  additional_attributes => {
    'redirectPort' => '8543',
  },
}
-> tomcat::service { 'tomcat1':
  catalina_base => '/opt/tomcat1',
}
