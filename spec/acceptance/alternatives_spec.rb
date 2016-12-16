require 'spec_helper_acceptance'

describe 'apache' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include 'yum'
        include 'cegekarepos'
        include 'profile::package_management'

        Yum::Repo <| title == 'cegeka-unsigned' |>
        sunjdk::instance { 'jdk-1.7.0_06-fcs':
          ensure      => 'present',
          jdk_version => '1.7.0_06-fcs'
        }

        alternative { "java:/usr/java/jdk1.7.0_06-fcs/bin/java":
          ensure => present,
          slave  => [ 
            {name  => "appletviewer", link => "/usr/bin/appletviewer", path => "/usr/java/jdk1.7.0_06-fcs/bin/appletviewer"},
            {name  => "apt", link => "/usr/bin/apt", path => "/usr/java/jdk1.7.0_06-fcs/bin/apt"},
            {name  => "extcheck", link => "/usr/bin/extcheck", path => "/usr/java/jdk1.7.0_06-fcs/bin/extcheck"},
            {name  => "HtmlConverter", link => "/usr/bin/HtmlConverter", path => "/usr/java/jdk1.7.0_06-fcs/bin/HtmlConverter"},
            {name  => "idlj", link => "/usr/bin/idlj", path => "/usr/java/jdk1.7.0_06-fcs/bin/idlj"},
            {name  => "javah", link => "/usr/bin/javah", path => "/usr/java/jdk1.7.0_06-fcs/bin/javah"},
            {name  => "javap", link => "/usr/bin/javap", path => "/usr/java/jdk1.7.0_06-fcs/bin/javap"},
            {name  => "jconsole", link => "/usr/bin/jconsole", path => "/usr/java/jdk1.7.0_06-fcs/bin/jconsole"},
            {name  => "jdb", link => "/usr/bin/jdb", path => "/usr/java/jdk1.7.0_06-fcs/bin/jdb"},
            {name  => "jhat", link => "/usr/bin/jhat", path => "/usr/java/jdk1.7.0_06-fcs/bin/jhat"},
            {name  => "jinfo", link => "/usr/bin/jinfo", path => "/usr/java/jdk1.7.0_06-fcs/bin/jinfo"},
            {name  => "jmap", link => "/usr/bin/jmap", path => "/usr/java/jdk1.7.0_06-fcs/bin/jmap"},
            {name  => "jrunscript", link => "/usr/bin/jrunscript", path => "/usr/java/jdk1.7.0_06-fcs/bin/jrunscript"},
            {name  => "jsadebugd", link => "/usr/bin/jsadebugd", path => "/usr/java/jdk1.7.0_06-fcs/bin/jsadebugd"},
            {name  => "jstack", link => "/usr/bin/jstack", path => "/usr/java/jdk1.7.0_06-fcs/bin/jstack"},
            {name  => "jstat", link => "/usr/bin/jstat", path => "/usr/java/jdk1.7.0_06-fcs/bin/jstat"},
            {name  => "jstatd", link => "/usr/bin/jstatd", path => "/usr/java/jdk1.7.0_06-fcs/bin/jstatd"},
            {name  => "jvisualvm", link => "/usr/bin/jvisualvm", path => "/usr/java/jdk1.7.0_06-fcs/bin/jvisualvm"},
            {name  => "native2ascii", link => "/usr/bin/native2ascii", path => "/usr/java/jdk1.7.0_06-fcs/bin/native2ascii"},
            {name  => "orbd", link => "/usr/bin/orbd", path => "/usr/java/jdk1.7.0_06-fcs/bin/orbd"},
            {name  => "pack200", link => "/usr/bin/pack200", path => "/usr/java/jdk1.7.0_06-fcs/bin/pack200"},
            {name  => "policytool", link => "/usr/bin/policytool", path => "/usr/java/jdk1.7.0_06-fcs/bin/policytool"},
            {name  => "rmic", link => "/usr/bin/rmic", path => "/usr/java/jdk1.7.0_06-fcs/bin/rmic"},
            {name  => "rmid", link => "/usr/bin/rmid", path => "/usr/java/jdk1.7.0_06-fcs/bin/rmid"},
            {name  => "rmiregistry", link => "/usr/bin/rmiregistry", path => "/usr/java/jdk1.7.0_06-fcs/bin/rmiregistry"},
            {name  => "schemagen", link => "/usr/bin/schemagen", path => "/usr/java/jdk1.7.0_06-fcs/bin/schemagen"},
            {name  => "serialver", link => "/usr/bin/serialver", path => "/usr/java/jdk1.7.0_06-fcs/bin/serialver"},
            {name  => "servertool", link => "/usr/bin/servertool", path => "/usr/java/jdk1.7.0_06-fcs/bin/servertool"},
            {name  => "tnameserv", link => "/usr/bin/tnameserv", path => "/usr/java/jdk1.7.0_06-fcs/bin/tnameserv"},
            {name  => "unpack200", link => "/usr/bin/unpack200", path => "/usr/java/jdk1.7.0_06-fcs/bin/unpack200"},
            {name  => "wsgen", link => "/usr/bin/wsgen", path => "/usr/java/jdk1.7.0_06-fcs/bin/wsgen"},
            {name  => "wsimport", link => "/usr/bin/wsimport", path => "/usr/java/jdk1.7.0_06-fcs/bin/wsimport"},
            {name  => "xjc", link => "/usr/bin/xjc", path => "/usr/java/jdk1.7.0_06-fcs/bin/xjc"},
        ]
      }
 
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/var/lib/alternatives/java') do
      it { should be_file }
      it { should contain '/usr/bin/HtmlConverter' }
    end

  end
end
