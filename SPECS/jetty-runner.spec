# Set to 0.1 etc for release candidates, and 1 etc for releases
%define release_number 1

Name: jetty-runner
Version: %{nr_ver}
Release: %{release_number}%{dist}
License: ASL 2.0
URL: http://www.eclipse.org/jetty/
Source0: https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/%{nr_ver}/jetty-runner-%{nr_ver}.jar
Summary: Jetty Runner (GBIF)
BuildArch: noarch

%{?systemd_requires}
%define _unitdir /usr/lib/systemd/system

Requires: java-11-headless

%description
Jetty Runner packaged by GBIF for the Integrated Publishing Toolkit (IPT); see https://ipt.gbif.org/manual

This package is provided since Jetty Runner is not included in EL8 or EL9

%prep
cp %{SOURCE0} jetty-runner.jar

%install
install -D -p -m 644 jetty-runner.jar %{buildroot}%{_javadir}/jetty/jetty-runner.jar

%files
%{_javadir}/jetty/jetty-runner.jar
