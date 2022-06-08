all: rpm

clean:
	rm -rf RPMS

rpm:
	bash docker-build.sh

deploy-testing:
	scp -p RPMS/noarch/jetty-runner*.el8.noarch.rpm static-vh.gbif.org:/var/www/html/packages/el8/testing/rpm/
	scp -p RPMS/noarch/jetty-runner*.el9.noarch.rpm static-vh.gbif.org:/var/www/html/packages/el9/testing/rpm/
	ssh static-vh.gbif.org sudo /usr/bin/createrepo --checkts --update /var/www/html/packages/el8/testing/rpm/
	ssh static-vh.gbif.org sudo /usr/bin/createrepo --checkts --update /var/www/html/packages/el9/testing/rpm/

deploy:
	scp -p RPMS/noarch/jetty-runner*.el8.noarch.rpm static-vh.gbif.org:/var/www/html/packages/el8/rpm/
	scp -p RPMS/noarch/jetty-runner*.el9.noarch.rpm static-vh.gbif.org:/var/www/html/packages/el9/rpm/
	ssh static-vh.gbif.org sudo /usr/bin/createrepo --checkts --update /var/www/html/packages/el8/rpm/
	ssh static-vh.gbif.org sudo /usr/bin/createrepo --checkts --update /var/www/html/packages/el9/rpm/

.PHONY: all
