FROM centos:centos7
MAINTAINER Bryan Robbins <bryantrobbins@gmail.com>

# Get latest packages
RUN yum clean all -y
RUN yum update

# Needed for latex-related jenkins jobs
RUN yum -y install texlive texlive-latex texlive-xetex texlive-collection-latex texlive-collection-latexrecommended texlive-xetex-def texlive-collection-xetex

# Install Gradle (used to drive jobs)
RUN yum install -y unzip
ADD https://services.gradle.org/distributions/gradle-2.13-bin.zip /
RUN unzip gradle-2.13-bin.zip
RUN mv /gradle-2.13 /gradle
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
