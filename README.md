# Static/Dynamic Application Security Testing Tools
This is a collection of static and dynamic security testing tools (SAST/DAST) from Timo Pagel. Initially created for team security checks along with a simplified OWASP Testing Guide v4 Checklist (see https://github.com/wurstbrot/OWASP-Testing-Checklist). 

## Vagrant

### Hosts file
```
192.168.205.86 securitytest.local
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


##Usage of SAST-Tools:
### PHP
* PHP_CodeSniffer (Code Style): <pre>sudo ./.config/composer/vendor/bin/phpcs /srv/www/skeleton.local/htdocs/`<`project`>`</pre>
* pixy: <pre>sudo /home/vagrant/pixy/run-all.pl /srv/www/skeleton.local/htdocs/`<`project`>`/file</pre>
* RIPS: http://securitytest.local/rips/index.php
* Web Application Protector: <pre>cd /home/vagrant/wap-2.1 && java -Xmx2g -Xss1g -jar /home/vagrant/wap-2.1/wap.jar -a -all -p /srv/www/skeleton.local/htdocs/`<`project`>`</pre>
* SensioLabs Security Checker: https://github.com/sensiolabs/security-checker
* composer-versions-check: https://github.com/Soullivaneuh/composer-versions-check

### JS
* retire.js: <pre>sudo retire --js --jspath /srv/www/skeleton.local/htdocs/`<`project`>`</pre>
* jsprime: http://securitytest.local:8888/
* eslint: <pre>cd `<`project`>` && eslint .</pre>

#Usage of DAST-Tools:
* arachni: <pre>/home/vagrant/arachni-1.4-0.5.10/bin/arachni_web --host 0.0.0.0 &</pre>, go to http://securitytest.local:9292/ (admin@admin.admin / administrator); Tipp: Use autologin Plugin
* Nessus, go to http://www.tenable.com/products/nessus-vulnerability-scanner
* metasploit, go to https://www.rapid7.com/products/metasploit/download.jsp
* retire.js: <pre>sudo retire --js --jspath /srv/www/skeleton.local/htdocs/`<`project`>`</pre>
* sqlmap: <pre>/home/vagrant/sqlmap/sqlmap.py -u http://project.local/index.php?x=1 </pre>
* testssl.sh: /home/vagrant/testssl.sh/testssl.sh https://www.fhunii.com</pre>
* OWASP Zap: Go to https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project and follow instructions

#Examples for Infrastructure-Tests
* Lynis: /home/vagrant/lynis/lynis  audit system --auditor "Timo Pagel"
* Iniscan: /home/vagrant/.config/composer/vendor/psecio/iniscan/bin/iniscan scan --path <path-to-php.ini>
