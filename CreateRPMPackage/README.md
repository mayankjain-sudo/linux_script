Create RPM package of any shell script.

 labadmin@labadmin:~ mkdir -p rpms/BUILDROOT/script-1.0-1.x86_64/usr/bin/
 labadmin@labadmin:~ cp script.sh rpms/BUILDROOT/script-1.0-1.x86_64/usr/bin/
 labadmin@labadmin:~ script.spec
 labadmin@labadmin:~ rpmbuild -bb script.spec
 Above command will create the RPM package in /home/labadmin/rpmbuild/RPMS/x86_64 
