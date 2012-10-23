# Chef with Ruby (ubuntu precise-x86_64)

## Description
Just type 2 Commands, Chef ready.

### Tested on
* ubuntu (12.04)

Please [report](/higanworks/chef-with-ruby_precise-x86_64/issues) any additional versions so they can be added.

## Include

* Ruby 1.9.3-p286
* Chef 10.16.0 (update easily)
* librarian
* cucumber
* foodcritic


## Usage
Clone Ruby and Chef from github.

<pre><code>$ apt-get install git
$ git clone https://github.com/higanworks/chef-with-ruby_`lsb_release -cs`-`uname -i`.git /opt/ruby-chef
</code></pre>


<pre><code># /opt/ruby-chef/bin/chef-solo -v
Chef: 10.16.0

# /opt/ruby-chef/bin/shef -v
Chef: 10.16.0

# /opt/ruby-chef/bin/ohai -v
Ohai: 6.14.0
</code></pre>

#### update chef 
`/opt/ruby-chef/bin/gem update chef --no-ri --no-rdoc`

## Notice: with rvm
`rvm use system` first, or keep default ruby to `system`.  
ex) `rvm use system --default`

or use rvm-shell
`/usr/local/rvm/bin/rvm-shell system -c '/opt/ruby-chef/bin/chef-solo'`  
or create own gemset for chef and use chef under rvm.

## ruby install log

### install dependencies

reference: rvm reqirememts  
> /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config


### make libyaml and ruby

Perform `rvm install 1.9.3 --disable-binary` before make for download sources.
<pre><code>cd /usr/local/rvm/src/yaml-0.1.4
make clean
./configure --prefix=/opt/ruby-chef/usr --no-create --no-recursion 
make -j 4
make install

cd /usr/local/rvm/src/ruby-1.9.3-p286
make clean
./configure "--prefix=/opt/ruby-chef/" '--disable-install-doc' '--with-opt-dir=/opt/ruby-chef/usr'
make -j 4
make install
</code></pre>

### chef
<pre><code>/opt/ruby-chef/bin/gem install chef --no-ri --no-rdoc</code></pre>

### cucumber
<pre><code>/opt/ruby-chef/bin/gem install cucumber --no-ri --no-rdoc</code></pre>

### librarian
<pre><code>/opt/ruby-chef/bin/gem install librarian --no-ri --no-rdoc</code></pre>

### foodcritic
<pre><code>/opt/ruby-chef/bin/gem install foodcritic --no-ri --no-rdoc</code></pre>


Setup your server with librarian-chef.
-----
Librarian manages cookbooks like bundler.  [https://github.com/applicationsonline/librarian](https://github.com/applicationsonline/librarian)

### Initializing Cheffile

Change WorkingDirectory to `/opt/ruby-chef`.


### using sample Cheffile
List cookbooks like bundler Gemfile.

`cp Cheffile.sample Cheffile`

----
`Cheffile.sample`

<pre><code>#!/usr/bin/env ruby
#^syntax detection

site 'http://community.opscode.com/api/v1'

cookbook 'apt'


# external
cookbook 'rvm',
  :git => 'https://github.com/fnichol/chef-rvm'


# my cookbooks
cookbook 'nginx_ppa',
  :git => 'https://github.com/higanworks-cookbooks/nginx_ppa.git'

cookbook 'monit_binaries',
  :git => 'https://github.com/higanworks-cookbooks/monit_binaries.git'

cookbook 'redis_src',
  :git => 'https://github.com/higanworks-cookbooks/redis_src.git'</code></pre>


### Download cookbooks
`./bin/librarian-chef install`

Librarian downloads cookbooks from repositories and writes dependencies to `Cheffile.lock`.

<pre><code># ./bin/librarian-chef install
# ./bin/librarian-chef show
apt (1.4.8)
monit_binaries (0.0.1)
nginx_ppa (0.0.1)
redis_src (0.0.1)
rvm (0.9.1)
</code></pre>

### Run recipeis with chef-solo

#### single recipe
`# ./bin/chef-solo -c solo.rb -o nginx_ppa::default`

**Execution example**

<pre><code># ./bin/chef-solo -c solo.rb -o nginx_ppa::default
-- snip --
[2012-09-19T20:29:28-07:00] INFO: Processing package[nginx] action install (nginx_ppa::default line 34)
-- snip --

# nginx -v
nginx version: nginx/1.2.3</code></pre>

#### multi recipes
`./bin/chef-solo -c solo.rb -j ./sample.json`


----
`sample.json`
<pre><code>{
   "rvm" : {
      "default_ruby" : "system",
      "rubies" : [
         "ruby-1.9.3-p194"
      ]
   },
   "run_list" : [
      "recipe[apt]",
      "recipe[nginx_ppa]",
      "recipe[monit_binaries]",
      "recipe[redis_src]",
      "recipe[rvm::system]"
   ]
}
</code></pre>

**Execution example**

<pre><code># ./bin/chef-solo -c solo.rb -j ./sample.json
[2012-09-19T20:28:35-07:00] INFO: *** Chef 10.14.2 ***
[2012-09-19T20:28:35-07:00] INFO: Setting the run_list to ["recipe[apt]", "recipe[nginx_ppa]", "recipe[monit_binaries]", "recipe[redis_src]", "recipe[rvm::system]"] from JSON
[2012-09-19T20:28:35-07:00] INFO: Run List is [recipe[apt], recipe[nginx_ppa], recipe[monit_binaries], recipe[redis_src], recipe[rvm::system]]

-- snip --

# redis-server -v
Redis server version 2.4.16 (04a08723:1)

# monit -V
This is Monit version 5.4
Copyright (C) 2001-2012 Tildeslash Ltd. All Rights Reserved.

# nginx -v
nginx version: nginx/1.2.3</code></pre>


Appendix:Bootstrap your own Chef-Server
----

<pre><code>cd /opt/ruby-chef
cp Cheffile.bootstrap-server Cheffile
./bin/librarian-chef install
./bin/chef-solo -c solo.rb -j bootstrap-server.json</code></pre>

Wait few minutes, Chef-WebUI is launched at port 4040.  
Default id/password is **"admin/p@ssword"**.

### Oprion: Chef-Server API and Web-UI use HTTPS over nginx proxy.

put sample comfig to `/etc/nginx/site-available` and create link to it.  
Reference: `Opscode chef-server cookbook.`

**Sample Config: /etc/nginx/sites-available/chef_server_proxy.conf **

<pre><code>upstream chef_server {
  server 127.0.0.1:4000 fail_timeout=0;
}

upstream chef_server_webui {
  server 127.0.0.1:4040 fail_timeout=0; 
}

server {                                                                                                                                    [33/1963]
  listen 443 ssl;
  ssl_certificate /etc/chef/certificates/cert.pem;
  ssl_certificate_key /etc/chef/certificates/key.pem;
  server_name localhost;
  access_log /var/log/nginx/chef-server.access.log;
  error_log /var/log/nginx/chef-server.error.log warn;

  root /usr/share/chef-server-webui/public;
  
  location @chef_server {
    proxy_set_header X-Forwarded-Proto https;
    proxy_set_header Host $http_host;

    proxy_pass http://chef_server;
  }
  
  location / {
    try_files $uri @chef_server;
  }
}

server {
  listen 444 ssl;
  ssl_certificate /etc/chef/certificates/cert.pem;
  ssl_certificate_key /etc/chef/certificates/key.pem;
  server_name localhost;
  access_log /var/log/nginx/chef-server.access.log;
  error_log /var/log/nginx/chef-server.error.log warn;

  root /usr/share/chef-server-webui/public;
  
  location @chef_server_webui {
    proxy_set_header X-Forwarded-Proto https;
    proxy_set_header Host $http_host;

    proxy_pass http://chef_server_webui;
  }

  location ~ ^.+\.css$ {
    expires 120h;

    try_files $uri @chef_server_webui;
  }

  location ~ ^.+\.js$ {
    expires 24h;

    try_files $uri @chef_server_webui;
  }

  location / {
    try_files $uri @chef_server_webui;
  }
}
</code></pre>


License
-------

Copyright (c) 2011-2012 HiganWorks LLC.

Released under the terms of the MIT License.
