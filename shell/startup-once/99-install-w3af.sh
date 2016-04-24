#!/bin/bash

sudo apt-get install -y w3af-console

cat > /home/vagrant/audit.w3af <<EOF
# -----------------------------------------------------------------------------------------------------------
#                                              W3AF AUDIT SCRIPT FOR WEB APPLICATION
# -----------------------------------------------------------------------------------------------------------
#Configure HTTP settings
http-settings
set timeout 30
back
#Configure scanner global behaviors
misc-settings
set max_discovery_time 20
set fuzz_cookies True
set fuzz_form_files True
set fuzz_url_parts True
set fuzz_url_filenames True
back
plugins
#Configure entry point (CRAWLING) scanner
crawl web_spider
crawl config web_spider
set only_forward False
set ignore_regex (?i)(logout|disconnect|signout|exit)+
back
#Configure vulnerability scanners
##Specify list of AUDIT plugins type to use
audit blind_sqli, buffer_overflow, cors_origin, csrf, eval, file_upload, ldapi, lfi, os_commanding, phishing_vector, redos, response_splitting, sqli, xpath, xss, xst
##Customize behavior of each audit plugin when needed
audit config file_upload
set extensions jsp,php,php2,php3,php4,php5,asp,aspx,pl,cfm,rb,py,sh,ksh,csh,bat,ps,exe
back
##Specify list of GREP plugins type to use (grep plugin is a type of plugin that can find also vulnerabilities or informations disclosure)
grep analyze_cookies, click_jacking, code_disclosure, cross_domain_js, csp, directory_indexing, dom_xss, error_500, error_pages, 
html_comments, objects, path_disclosure, private_ip, strange_headers, strange_http_codes, strange_parameters, strange_reason, url_session, xss_protection_header
##Specify list of INFRASTRUCTURE plugins type to use (infrastructure plugin is a type of plugin that can find informations disclosure)
infrastructure server_header, server_status, domain_dot, dot_net_errors
#Configure target authentication
auth detailed
auth config detailed
set username admin
set password password
set method POST
set auth_url http://pcdom/dvwa/login.php
set username_field user	
set password_field pass
set check_url http://pcdom/dvwa/index.php
set check_string 'admin'
set data_format username=%U&password=%P&Login=Login
back
#Configure reporting in order to generate an HTML report
output console, html_file
output config html_file
set output_file /tmp/W3afReport.html
set verbose False
back
output config console
set verbose False
back
back
#Set target informations, do a cleanup and run the scan
target 
set target http://pcdom/dvwa
set target_os windows
set target_framework php
back
cleanup
start
EOF

