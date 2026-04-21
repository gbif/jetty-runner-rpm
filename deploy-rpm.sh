#!/bin/bash -e

uploaded=false

if compgen -G "RPMS/noarch/jetty-runner*.el8.noarch.rpm" > /dev/null; then
  echo "Uploading EL8 RPMs"
  scp -p RPMS/noarch/jetty-runner*.el8.noarch.rpm jenkins-deploy@apache.gbif.org:/var/www/html/packages/el8/rpm/
  uploaded=true
fi

if compgen -G "RPMS/noarch/jetty-runner*.el9.noarch.rpm" > /dev/null; then
  echo "Uploading EL9 RPMs"
  scp -p RPMS/noarch/jetty-runner*.el9.noarch.rpm jenkins-deploy@apache.gbif.org:/var/www/html/packages/el9/rpm/
  uploaded=true
fi

if [ "$uploaded" = true ]; then
  ssh jenkins-deploy@apache.gbif.org /var/www/html/packages/reindex
else
  echo "No RPMs created"
fi