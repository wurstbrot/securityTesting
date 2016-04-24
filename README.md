# Static/Dynamic Application Security Testing Tools

## Vagrant

### Hosts file
```
127.0.0.1 skeleton.local
```

### Starting your Vagrant box

This will start an existing or create a new box (if not already created).

```
vagrant up
```

### SSH into Vagrant Box
```
vagrant ssh
```

If you were asked for a password enter 'vagrant'.


#Usage of SAST-Tools:
* arachni: http://skeleton.local:9292 (admin@admin.admin / administrator); Tipp: Use autologin Plugin
* Iniscan: /home/vagrant/.config/composer/vendor/psecio/iniscan/bin/iniscan scan --path <path-to- php.ini>
* PHP_CodeSniffer (Code Style): sudo ./.config/composer/vendor/bin/phpcs /srv/www/skeleton.local/htdocs/<project>
* pixyi: sudo /home/vagrant/pixy/run-all.pl /srv/www/skeleton.local/htdocs/<project>/file
* RIPS: http://skeleton.local:8086/rips/index.php
* retire.js: sudo retire --js --jspath /srv/www/skeleton.local/htdocs/<project>
* SensioLabs Security Checker: php /home/vagrant/security-checker.phar security:check <project>/composer.lock
* Web Application Protector: cd /home/vagrant/wap-2.1 && java Xmx2g -Xss1g -jar /home/vagrant/wap-2.1/wap.jar -a -all -p /srv/www/skeleton.local/htdocs/<project>

#Usage of DAST-Tools:
* Nessus, go to http://www.tenable.com/products/nessus-vulnerability-scanner
* metasploit, go to https://www.rapid7.com/products/metasploit/download.jsp
* retire.js: sudo retire --js --jspath /srv/www/skeleton.local/htdocs/<project>
* sqlmap: /home/vagrant/sqlmap/sqlmap.py -u http://project.local/index.php?x=1 
* testssl.sh: /home/vagrant/testssl.sh/testssl.sh https://www.fhunii.com
* OWASP Zap: Go to https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project and follow instructions
* w3af: w3af

#Examples for Infrastructure-Tests
* Lynis: /home/vagrant/lynis/lynis  audit system --auditor "Timo Pagel"
