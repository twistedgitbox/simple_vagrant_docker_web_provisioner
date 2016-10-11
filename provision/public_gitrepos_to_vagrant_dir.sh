#!/bin/bash

# INSTRUCTIONS

# This file grabs the files from public repositories and stores them in the /vagrant directory for easy access.
# Files are stored in the repositories directory on /vagrant directory
# Folders in the repositories directory are stored by username and project names in the username folder.
# Both user and project names are extracted from the github URL

# Users can also designate a docker directory or a web directory from which to place files in a special web or docker directory.
# The user does this by calling the git_grab function, followed by the complete github URL,including .git ending.
# If the user wishes to designate a web or docker repository, place the word WEB or DOCKER afterwards.

# Example:
# git_grab FIRST_URL.git WEB

# Github does not allow spaces in the URL but if the user adds spaces in the URL the program will fail.
# It is also important that user keep a space between the URL and the designator.
# Designators must be all capitals and match either WEB or DOCKER exactly.

# The extraction takes the first word as URL to break into sections and the second as the designator for special actionsa

# At the very end of the file, the user can add new URLs by calling the git_grab function

# Only one Docker or Web repositories can be used at a time. If the user selects more than one, then the last repository selected in that category will be used.


# This file uses two primary functions:

# `git_grab`, which extracts the information from the URL provided with or without the designator)

#`check_replace_repo`, which checks if the folder exists.

# If the folder exists, the program will check the repository and pull the latest (master) branch from the github repository into the folder location.
# If the folder does not exist, the program will create the folder and clone the repository into the new folder location.

needs_stash(){
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

git_grab(){
    url=$1

    url_without_suffix="${url%.*}"
    echo "From git url: $url_without_suffix"
    reponame="$(basename "${url_without_suffix}")"
    echo "Project folder: $reponame"
    hostname="$(basename "${url_without_suffix%/${reponame}}")"
    echo "User folder: $hostname"
#    DIR=i./vagrant/repositories/`basename $1 .git`
    echo "Installing repo from:$url_without_suffix now to folder:$reponame in folder:$hostname in /vagrant/repositories"

    # Set install directory for repository files in repositories folder in /vagrant directory.
    # If git repository url is followed by either WEB or DOCKER then:
    # On case WEB - place files in web folder in /vagrant directory
    # On case DOCKER - place files in docker folder in /vagrant/directory
    # Otherwise user repositories folder to store files by repository name in the folder of the github username

    case $2 in
    #Case WEB - to www folder
    WEB)
      echo "Set or replace contents of /vagrant/web folder"
      rm -rf /vagrant/web/
      DIR=/vagrant/web/
      check_replace_repo $DIR

      # To prevent errors when multiple repositories are copied to the same folders, the www and dockerfiles are wiped on selection of a WEB or DELETE designator in the git_grab function

      ;;

    #Case DOCKER -  to dockerfiles folder
    DOCKER)
      echo "Set or replace contents of /vagrant/docker folder"
      rm -rf /vagrant/docker/
      DIR=/vagrant/docker/

      # I kept the check here because I plan to make the collection of git repositories for docker & web to be an option not automated later
      check_replace_repo $DIR
            ;;

    # Normal Repositories
    *)
      echo "Placing repository in repositories folder by username by project"
      DIR=/vagrant/repositories/$hostname/$reponame
      check_replace_repo $DIR
      ;;
    esac

}

check_replace_repo(){

    # Check if the repository folder exists, if not clone it. If so, do a git pull in the folder to assure newest commits are in the folders stored in the vagrant instance.

    echo "Place in this directory --> $DIR"
    if [ ! -d $DIR ]; then
      git clone $url $DIR
    else
      # Directory exists so do git pull to get latest commits
      pushd $DIR
      if needs_stash; then
        # Do git stash"
        git stash
        # Do git pull
        git pull --quiet
        git stash pop
      else
        # No stash needed, just git pull"
        git init
        remote_addr=(git remote -v)
        # Easier to reset remote address here
        git remote set-url origin $url > /dev/null 2>&1
        git pull origin master --quiet
      fi
      echo "Finished with checks, files are placed or updated."
      popd
    fi
}




echo "Please use find the IP address of the vagrant instance using ifconfig. I have set it to 192.168.0.60."
echo "Access the website at port 8000"

# To prevent errors when multiple repositories are copied to the same folders, the www and dockerfiles f

#####################ENTER REQUESTED PUBLIC REPOSITORIES AFTER THIS COMMENT GROUP#####

#Enter information for public repositories in the following format:
# git_grab github_url
# Follow with WEB or DOCKER to designate that repositories for either the web or docker folder.
# WEB for files you wish to make available to display, these will be stored in the /vagrant/web directory
# DOCKER for the docker files including docker-compose that will build the docker instance which will be stored in the /vagrant/docker directory


# EXAMPLE:

# git_grab https://github.com/twistedgitbox/TestforChanges.git
#
# git_grab https://github.com/puppetlabs/exercise-webpage.git WEB
#
# git_grab https://github.com/twistedgitbox/simple_nginx.git DOCKER

    # Check if it is in the proper format for a github repository URL
    # Also identify if the designator for the URL to set the repository to the WEB or DOCKER folder exists
    # Otherwise install to the normal location of /vagrant/repositories


# NOTE: Private repositories will need additional code to deal with the SSL requirements

git_grab https://github.com/twistedgitbox/TestforChanges.git
#
git_grab https://github.com/puppetlabs/exercise-webpage.git WEB
#
https://github.com/twistedgitbox/vagrant-simple-flask-with-docker-nginx.git
#
git_grab https://github.com/twistedgitbox/simple_nginx.git DOCKER
#
git_grab https://github.com/pixelsign/html5-device-mockups.git

