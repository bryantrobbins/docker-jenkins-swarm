FROM ubuntu:14.04
MAINTAINER Bryan Robbins <bryantrobbins@gmail.com>

# Get latest packages
RUN echo "http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update && apt-get clean

# Needed for Jenkins
RUN apt-get install --no-install-recommends openjdk-7-jdk -y

# Needed for Jenkins jobs
RUN apt-get install ant wget unzip bzip2 xvfb git -y

# Needed for R
RUN apt-get install r-base r-base-dev libxml2-dev libcurl3-dev -y
ADD install.r /install.r
RUN Rscript install.r

# Install Gradle
ADD https://services.gradle.org/distributions/gradle-2.6-bin.zip /
RUN unzip gradle-2.6-bin.zip
RUN mv /gradle-2.6 /gradle
ENV PATH $PATH:/gradle/bin

# Create slave user
RUN groupadd -r jslave && useradd -r -g jslave jslave

# Install swarm agent and start script wrapper
ADD http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar /home/jslave/swarm.jar
ADD start.sh /home/jslave/start.sh
RUN chmod 700 /home/jslave/start.sh

EXPOSE 22
EXPOSE 5005

# Prepare for jslave user
RUN chown -R jslave:jslave /home/jslave
USER jslave
WORKDIR /home/jslave

# Prepare command for launching swarm client
CMD    ["./start.sh"]
