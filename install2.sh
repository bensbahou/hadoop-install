

export JAVA_HOME=/usr/java/
export PATH=$PATH:$JAVA_HOME/bin
export HADOOP_HOME=/opt/hadoop/
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"
export HADOOP_CLASSPATH=$(hadoop classpath)
export HADOOP_CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

source ~/.bashrc


mkdir -p /opt/hadoop/hadoopdata/namenode
mkdir -p /opt/hadoop/hadoopdata/datanode
#chown -R hduser:hadoop  /opt/hadoop

