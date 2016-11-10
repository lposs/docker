# Docker build files for the ForgeRock stack

## Warning
**This code is not supported by ForgeRock and it is your responsibility to verify that the software is suitable and safe for use.**

## Contributing 

If you are reading this on github, this is a mirror of the master 
repo at https://stash.forgerock.org/projects/DOCKER/repos/docker/browse 

Any pull requests or issues should be filed on the stash project. You 
will need a ForgeRock community account to create PRs or issues.

To create a pull request, fork the project to your private community stash account, clone it to your workstation,
commit your changes and push them up to your stash account. You can create a pull request on stash.
``

## About

This is a work in progress. You will need to modify the Dockerfiles here to suit
your needs. The Dockerfiles are changing quite often as we find better ways to build these images
for a wide range of requirements. 


The provided build scripts downloads nightly builds from ForgeRock's maven repo
and will build and tag the docker images. You may need to setup your
own maven mirror for these artifacts.

## Building

There are three ways to build the Docker images:

* Manually. Copy the relevant artifacts (example: openam.war) to the directory
and run ```docker build -t openam openam```. The included maven pom.xml
can download artifacts from maven for you.
* Use the build.sh shell script. This does essentially the same as a 
manual build
* Gradle.   Executing ```./gradlew```  will by default download the products
and build them. If you are using nightly snapshots, you may need
to use ```./gradlew --refresh-dependencies``` to get gradle to download the latest 
release.


# Building Minor or Patch Releases

If you want to use a major or minor release (OpenAM 13.0.1, for example), log on to
backstage.forgerock.com and download the appropriate binary. The binary should be
placed in the Docker build directory (e.g. openam/) and should not have any
version info (openam.war, not OpenAM-13.0.1.war).


# Kubernetes

If you are interested in running on a Kubernetes cluster,
see  [here](https://github.com/ForgeRock/fretes)


# How to run these images

Please see the README.md in each directory.  
