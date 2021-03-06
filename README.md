####Puppet Scripts for deployment of Project Dristhi

Puppet scripts for deployment of environments needed for [Project Dristhi](https://github.com/SEL-Columbia/dristhi)

####Setup instructions
Install [Vagrant](https://www.vagrantup.com/downloads.html) 
Create a vagrant box with the following command
````
vagrant box add CentOS6.5 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140311.box
````
This should download/copy the box to your local directory

After the box is downloaded, you can start the box with the command
````
vagrant up
````
Once the box is up, the box can be provisioned to run Dristhi by running the command
```
vagrant provision
```
or
```
vagrant reload
```

or ssh to the box using 
````
vagrant ssh
````

Collaborators:

[Ashwin](https://github.com/ashwinkonale)
[Bharti Nagpal](https://github.com/bhartin)
[Devi Sridharan](https://github.com/devishree90)
[Kumaran](https://github.com/kumaranvram)
