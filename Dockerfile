# create centos image
FROM centos

# update the image
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN cd ~

#RUN yum update -y

RUN yum install openssh-clients -y
RUN yum install wget -y
RUN yum install passwd -y
RUN yum install which -y
RUN yum install ncurses -y

RUN wget https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz
RUN tar -zxvf jdk-8u212-linux-x64.tar.gz
RUN mv jdk1.8.0_212  /usr/java
# delete the tar file
RUN rm -rf jdk-8u212-linux-x64.tar.gz

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.9.2/hadoop-2.9.2.tar.gz
RUN tar xzf hadoop-2.9.2.tar.gz
RUN mv hadoop-2.9.2 /opt/hadoop
# delete the tar file
RUN rm -rf hadoop-2.9.2.tar.gz

ENV JAVA_HOME=/usr/java/
ENV PATH=$PATH:$JAVA_HOME/bin
ENV HADOOP_HOME=/opt/hadoop/
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"
#ENV HADOOP_CLASSPATH=$(hadoop classpath)
ENV HADOOP_CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

RUN source ~/.bashrc

ENV JAVA_HOME=/usr/java/
RUN mkdir -p /opt/hadoop/hadoopdata/namenode
RUN mkdir -p /opt/hadoop/hadoopdata/datanode

#RUN cd $HADOOP_HOME/etc/hadoop