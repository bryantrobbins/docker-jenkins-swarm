# What

I use the setup contained here to run Gradle and R jobs in parallel across distributed machines
as part of my research in model-based testing at the University of Maryland.

There are 3 components:
* jslave/: A Docker image for a Jenkins Swarm slave
* slave/ : Scripts for managing a "slave host" of Jenkins Swarm slaves
* master/: Scripts for managing a data-volume-backed "master host" with a Jenkins Master, MongoDB database, and Sonatype Nexus artifact repository

# Why

I carry out empirical research in software testing, and this often requires "massively parallel" execution of
long-running tests. I developed this infrastructure to make the most of my available hardware. I need to be
able to run long-term, file-intensive processing on one host and relatively short-lived test executions on
all of the other hosts I can manage to get my hands on.

Odds are you will not find every part of this setup useful (if you do, we should talk ... and publish research
papers together); however, you might still find it useful for things YOU need to do in parallel.

Also, I'm interested in getting feedback on this setup. I know that there are cooler alternatives out there
(e.g., the Jenkins Mesos plugin) but they seemed heavier-weight than what I wanted/needed when I started
this on my own in early 2014.

# How

Caveat: You should check the Known Issues below.

(Once those are fixed) if you want to try this out, you should be able to:
* (duh) Install Docker on some host
* Clone the repo
* Build the jslave image in jslave/
* Start the master with the scripts in master/ (it takes some arguments)
* Start some slaves with the start-slaves.sh script in slave/ (it takes some arguments)

Enjoy. Let me know what you think.

# Known issues

* The current jslave/Dockerfile refers to a local archive "sources.tar", and unpacks it to some weird places.
This doesn't make too much sense for general use ... I should probably clean it up.
* Figure out how to initially start the master (Right now, master-start requires an archive, but the first time
you run this, you won't have one. Can we start from nothing, or do we need to provide pre-built archive?)
