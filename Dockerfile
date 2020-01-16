FROM cloudbees/cloudbees-jenkins-distribution

MAINTAINER Adam Pratt

USER root

# add cloudbees-jenkins-distribution user to sudo user group
#RUN useradd -ms /bin/bash cloudbees-jenkins-distribution
#RUN echo "cloudbees-jenkins-distribution:password" | chpasswd
#RUN adduser cloudbees-jenkins-distribution sudo
#USER cloudbees-jenkins-distribution

# update pkg mgr and install Maven and Java 8, set environment variables
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install maven -y
RUN apt-get install openjdk-8-jre -y
ENV M2_HOME=/usr/share/maven
ENV JAVA_HOME=/usr/local/openjdk-8
ENV PATH=${PATH}:${M2_HOME}/bin
ENV PATH=${PATH}:${JAVA_HOME}/bin

ENV TIBCO_HOME="/opt/tibco"

# set environment variables
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Install Jenkins plugins
COPY plugins.txt /usr/share/cloudbees-jenkins-distribution/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/cloudbees-jenkins-distribution/ref/plugins.txt
ENV REF_DIR=${REF:-/var/lib/cloudbees-jenkins-distribution/plugins}

# install tibco BusinessWorks 6.4
RUN mkdir /tibco_bw6
COPY TIB_bwce-dev_2.5.0_linux26gl23_x86_64.zip /tibco_bw6
RUN unzip /tibco_bw6/TIB_bwce-dev_2.5.0_linux26gl23_x86_64.zip -d /tibco_bw6
RUN chmod 755 /tibco_bw6/TIB_bwce-dev_2.5.0_linux26gl23_x86_64/TIBCOUniversalInstaller_bwce_2.5.0.silent
RUN chmod 755 /tibco_bw6/TIB_bwce-dev_2.5.0_linux26gl23_x86_64/TIBCOUniversalInstaller_bwce_2.5.0-Copy.silent
RUN chmod 755 /tibco_bw6/TIB_bwce-dev_2.5.0_linux26gl23_x86_64/TIBCOUniversalInstaller-lnx-x86-64.bin
RUN /tibco_bw6/TIB_bwce-dev_2.5.0_linux26gl23_x86_64/TIBCOUniversalInstaller-lnx-x86-64.bin \
	-silent

# echo PATH and M2_HOME to see where Maven is installed
RUN echo $PATH
RUN echo $M2_HOME
RUN mvn -version

# install tibco bw6 maven plugin
RUN mkdir /tibco_bw6/plugins
COPY TIB_BW_Maven_Plugin_2.4.0.zip /tibco_bw6/plugins
RUN unzip /tibco_bw6/plugins/TIB_BW_Maven_Plugin_2.4.0.zip -d /tibco_bw6/plugins
RUN chmod 755 /tibco_bw6/plugins/install.sh
#RUN sh /tibco_bw6/plugins/install.sh $TIBCO_HOME

# Copy oge-bw-include.xml to /include directory
#RUN mkdir /include
#ADD oge-bw-include.xml /include

USER cloudbees-jenkins-distribution