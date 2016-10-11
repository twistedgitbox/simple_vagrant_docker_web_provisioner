##<span style="color:cyan">Simple Vagrant Docker & Web Provisioner</span>

###<span style="color:darkcyan">What is it for?</span>

This simple test is for use with a vagrant instance. This is a simpler version
of the [Vagrant__docker_web_selector](https://github.com/twistedgitbox/Vagrant_docker_web_selector.git)

Using the git repositories located in the `/provision` folder in the file
`public_gitrepos_to_vagrant_dir.sh` it downloads public gitrepositories innto
the following folders:

**For repositories marked `WEB`** the repository is downloaded into the
`/vagrant/web` folder on the Vagrant guest.

**For repositories marked `DOCKER`** the repository is downloaded into the
`/vagrant/docker` folder on the Vagrant guest. The docker-container is then
started using the `docker-compose.yml` file in the folder.

(*note: this does require a docker-compose folder to exist and to be in the root
directory of the repository*)

The `docker-compose.yml` file also needs to be in Version 1 format. This is
because the Vagrantfile uses the `phusion/ubuntu-14.04-amd64` image. This choice
was made because the image installs faster than the standard 14.04 image.

**If you would like to run 14.04 instead or use repositories that run `Version 2`
of *docker-compose* then please refer to the `Vagrant__docker_web_selector` in
the link at the start of this description.**

###<span style="color:darkcyan">Instructions</span>

**To run**:
- cd into folder
- type 'vagrant up'
- select the bridge for your network (usually `eth01`)
- After installation concludes, go to `localhost:8000` or the IP address of your
  Vagrant guest at port 8000.

**To change repositories to load and install:**
- cd into `provision` folder
- edit 'public_gitrepos_to_vagrant_dir.sh'
- find the section at the end `ENTER REQUESTED PUBLIC REPOSITORIES AFTER THIS
  COMMENT GROUP`
- type `git-grab` followed by the github URL of the repository (including .git)
- Leave a space between the URL
- For the repository you want in the /vagrant/web folder type `WEB`
- For the repository you want in the /vagrant/docker folder type `DOCKER`
- For any other repository leave the URL with nothing following the .git, the
  repository will be stored by username and project in the `repositories` folder




