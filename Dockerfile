FROM centos:centos6 
MAINTAINER Jonathan Temlett

# make sure centos is up to date and install unzip support to decompress I.M file later 
RUN yum update && yum install -y unzip 

# create user and group to use with websphere and Installation Manager 
RUN groupadd -r wasadmin && useradd -r -g wasadmin wasadmin 

# copy I.M to image 
COPY $installer.zip tmp/$installer.zip 

# unzip I.M install it and delete all files. The installation log is written to /opt/im_install.log 
RUN cd tmp && unzip $installer.zip && ./installc -log /opt/im_install.log -acceptLicense && rm -rf * 

# change the user owner for IBM folder and subfolders to be wasadmin:wasadmin . 
# I use this for WebSphere based products. 
RUN cd /opt && chown -R wasadmin:wasadmin IBM 
