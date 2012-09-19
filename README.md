# Chef with Ruby (ubuntu precise-x86_64)

## Description
Just type 2 Commands, Chef ready.


## Usage
Clone Ruby and Chef from github.

<pre><code>$ apt-get install git
$ git clone https://github.com/higanworks/chef-with-ruby_`lsb_release -cs`-`uname -i`.git /opt/ruby-chef
</code></pre>


<pre><code># /opt/ruby-chef/bin/chef-solo -v
Chef: 10.14.2

# /opt/ruby-chef/bin/shef -v
Chef: 10.14.2

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

Perform `rvm install 1.9.3` before make for download sources.
<pre><code>cd /usr/local/rvm/src/yaml-0.1.4
make clean
./configure --prefix=/opt/ruby-chef/usr --no-create --no-recursion 
make -j 4
make install

cd /usr/local/rvm/src/ruby-1.9.3-p194
make clean
./configure "--prefix=/opt/ruby-chef/" '--disable-install-doc' '--with-opt-dir=/opt/ruby-chef/usr'
make -j 4
make install
</code></pre>

### chef
<pre><code>/opt/ruby-chef/bin/gem install chef --no-ri --no-rdoc</code></pre>


