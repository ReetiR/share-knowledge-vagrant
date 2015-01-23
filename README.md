# README #

This is the vagrant configuration that we'll use for the backend development.

## Getting Started ##

* Install the latest version of VirtualBox from [here](https://www.virtualbox.org/wiki/Downloads)
* Install the latest version of vagrant from [here](https://www.vagrantup.com/downloads.html)

* Add the `ubuntu/trusty64` box to your local machine.

```
#!shell

vagrant box add ubuntu/trusty64
```


* Clone this repository to a location of your choice. For me its 
```
#!shell

~/vagrant/pucho
```

* Move into the directory
```
#!shell

cd ~/vagrant/pucho
```
* Run this command:

```
#!shell

vagrant up
```
* Wait for magic to happen.
* After seeing awesomeness, login to the VM using SSH:
```
#!shell

vagrant ssh
```

## Directory structure ##

The `web_server/vagrant` directory in the host machine is synced with the `/vagrant` directory in the guest machine.

The `web_server/home/vagrant` directory in the host machine is synced with the `/home/vagrant/synced` directory in the guest machine. All our code goes in here. Work in the `web_server/home/vagrant` directory from the host machine.

## Setting up the IDE ##
### Eclipse ###
* Download the latest eclipse. Preferably from [here](https://yoxos.eclipsesource.com/userdata/profile/38aee0f5ae3969922f6cfa39a3b76c19) so that all of us have the same eclipse development environment.
* SSH into the vagrant VM
```
#!shell

user@User-PC:~$ vagrant ssh
```


## Packages Installed ##

1. OpenJDK 7 JDK
2. Ruby Version Manager (RVM)
3. Ruby 1.9.3 (for librarian-puppet gem)
4. Git
5. Vim
6. MySQL 5.6
7. MongoDB
8. Redis

## To be installed ##

1. Beanstalkd
2. Play Framework