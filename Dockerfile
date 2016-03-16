# Base container
FROM python

# Maintainer
MAINTAINER Daniel Kristiyanto, daniel.kristiyanto@pnnl.gov

# Main Directory
WORKDIR /root

# Install Java
RUN apt-get update
RUN apt-get -q -y install default-jdk unzip
RUN apt-get clean
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

# Add MSGF plus
#ADD https://omics.pnl.gov/sites/default/files/software/MSGFPlus.20140716.zip /root/MSGF/
#RUN cd /root/MSGF/ && \
#	unzip -q MSGFPlus.20140716.zip && \
#   rm MSGFPlus.20140716.zip 
ADD MSGFPlus.jar /root/

# Add Entrypoint Script
ADD entry.py /root/

# Run on Entrypoint
CMD python /root/entry.py