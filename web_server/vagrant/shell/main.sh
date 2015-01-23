#!/bin/bash
error_exit () {
    echo "$1" 1>&2
    exit 1
}

check_last_apt_update () {
    NOW=$(date +%s)
    THEN=$(stat -c %X /var/cache/apt)

    if [ "$?" -ne 0 ]; then
        apt-get update
    fi

    DIFF=`expr $NOW - $THEN`

    if [ "$DIFF" -gt 7200 ]; then
        apt-get update
    fi

    if [ $? -ne 0 ]; then
        error_exit "Could not execute apt-get update. ABORTING."
    fi
}

install_git () {
    dpkg -s git &>/dev/null

    if [ "$?" -ne 0 ]; then
        echo "Installing git..."
        apt-get -q -y install git
    fi

    if [ "$?" -ne 0 ]; then
        error_exit "There was an error installing git. ABORTING."
    fi
}

install_curl () {
    dpkg -s curl &>/dev/null

    if [ "$?" -ne 0 ]; then
        echo "Installing cURL..."
        apt-get -q -y install curl
    fi

    if [ "$?" -ne 0 ]; then 
        error_exit "There was an error installing cURL. ABORTING."
    fi
}

install_rvm () {
    source /usr/local/rvm/scripts/rvm &>/dev/null
    which rvm &>/dev/null

    if [ "$?" -ne 0 ]; then
        gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
        echo "Installing RVM ..."
        curl -sSL https://get.rvm.io | bash -s stable
    fi
}

install_librarian_puppet () {
    gem list librarian-puppet -i
    if [ "$?" -ne 0 ]; then
        echo "Installing librarian-puppet gem ..."
        gem install librarian-puppet
    fi

    if [ "$?" -ne 0 ]; then
        error_exit "Failed to install librarian-puppet gem. ABORTING."
    fi
}

install_puppet_gem () {
    gem spec puppet &>/dev/null
    if [ "$?" -ne 0 ]; then
        echo "Installing puppet gem..."
        gem install puppet
    fi

    if [ "$?" -ne 0 ]; then
        error_exit "Failed to install puppet gem. ABORTING."
    fi
}

install_r10k_gem () {
    gem spec r10k &>/dev/null
    if [ "$?" -ne 0 ]; then
        echo "Installing r10k gem..."
        gem install r10k
    fi

    if [ "$?" -ne 0 ]; then
        error_exit "Failed to install r10k gem. ABORTING."
    fi
}

check_last_apt_update

install_git

install_curl

install_rvm

# make rvm available
source /usr/local/rvm/scripts/rvm || error_exit "No RVM found. Exiting."

# use ruby 1.9.3. If not present, install it.
rvm use --install 1.9.3

#install puppet gem
install_puppet_gem

#install r10k gem
install_librarian_puppet_gem

cd /vagrant/puppet || error_exit "Directory /vagrant/puppet does not exist. EXITING."

# install the modules listed in /vagrant/puppet/Puppetfile
librarian-puppet install --verbose



