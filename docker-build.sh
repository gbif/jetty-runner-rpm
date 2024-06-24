#!/bin/bash -e

# Check if the package version is up-to-date
nr_ver=$(curl -Ss 'https://search.maven.org/solrsearch/select?q=g:org.eclipse.jetty+a:jetty-runner+v:10*&rows=20&wt=json' | jq -r '.response.docs[0].v')

if curl -I --fail https://packages.gbif.org/el8/rpm/jetty-runner-$nr_ver-1.el8.noarch.rpm &> /dev/null; then
    echo "Version $nr_ver exists already, nothing to do"
    exit 0
fi

CURRENT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

mkdir -p $CURRENT_DIR/{RPMS,SOURCES}
chmod 777 $CURRENT_DIR/{RPMS,SOURCES}

echo
echo "EL8 build using Oracle Linux"
docker pull oraclelinux:8
docker run --rm \
       -e nr_ver=$nr_ver \
       -v $CURRENT_DIR/RPMS:/root/rpmbuild/RPMS/ \
       -v $CURRENT_DIR/SOURCES:/root/rpmbuild/SOURCES/ \
       -v $CURRENT_DIR/SPECS:/root/rpmbuild/SPECS/ \
       oraclelinux:8 \
       "/root/rpmbuild/SPECS/rpm-build.sh"

echo
echo "EL9 build using Oracle Linux"
docker pull oraclelinux:9
docker run --rm \
       -e nr_ver=$nr_ver \
       -v $CURRENT_DIR/RPMS:/root/rpmbuild/RPMS/ \
       -v $CURRENT_DIR/SOURCES:/root/rpmbuild/SOURCES/ \
       -v $CURRENT_DIR/SPECS:/root/rpmbuild/SPECS/ \
       oraclelinux:9 \
       "/root/rpmbuild/SPECS/rpm-build.sh"

chmod 755 $CURRENT_DIR/{RPMS,SOURCES}
