--pour 64 bits
#wget https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz     
--pour 32 bits
#wget https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-i586.tar.gz
#tar zxvf jdk-8u212-linux-x64.tar.gz  ou #tar zxvf jdk-8u212-linux-i586.tar.gz
#su
#mv jdk1.8.0_212  /usr/java   --attention au nom du repertoire après décompression

--Ajouter groupe hadoop et user hduser
#groupadd hadoop
#adduser  -G hadoop hduser
#passwd hduser
#su - hduser

--Configuration ssh pour activer un login sans mot de pass
#ssh-keygen -t rsa -P ""
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#chmod 0600 ~/.ssh/authorized_keys
--verification
#ssh localhost
#exit

--Télécharger hadoop
#wget https://archive.apache.org/dist/hadoop/core/hadoop-2.9.2/hadoop-2.9.2.tar.gz
#tar xzf hadoop-2.9.2.tar.gz
#su
#mv hadoop-2.9.2 /opt/hadoop
#su - hduser
--Définir Variables d'environement en editant ~/.bashrc
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

--Appliquer la définition des variables
source ~/.bashrc
#su
--editer le fichier $HADOOP_HOME/etc/hadoop/hadoop-env.sh  et définir la variable JAVA_HOME. Changer le path de java selon son installation sur le système.
export JAVA_HOME=/usr/java/

#mkdir -p /opt/hadoop/hadoopdata/namenode
#mkdir -p /opt/hadoop/hadoopdata/datanode
#chown -R hduser:hadoop  /opt/hadoop

--Editer les fichiers de configuration
$ cd $HADOOP_HOME/etc/hadoop

Edit core-site.xml

	<configuration>
	<property>
	  <name>fs.default.name</name>
	    <value>hdfs://localhost:9000</value>
	</property>
	</configuration>

Edit hdfs-site.xml

	<configuration>
	<property>
	 <name>dfs.replication</name>
	 <value>1</value>
	</property>

	<property>
	  <name>dfs.name.dir</name>
	    <value>file:/opt/hadoop/hadoopdata/namenode</value>
	</property>

	<property>
	  <name>dfs.data.dir</name>
	    <value>file:/opt/hadoop/hadoopdata/datanode</value>
	</property>
	</configuration>

#mv mapred-site.xml.template mapred-site.xml
Edit mapred-site.xml

	<configuration>
	 <property>
	  <name>mapreduce.framework.name</name>
	   <value>yarn</value>
	 </property>
	</configuration>

Edit yarn-site.xml

	<configuration>
	 <property>
	  <name>yarn.nodemanager.aux-services</name>
	    <value>mapreduce_shuffle</value>
	 </property>
	</configuration>
#su - hduser
--Formatage du Namenode
#hdfs namenode -format

--Démmarage des services hdfs et yarn
#start-dfs.sh
#start-yarn.sh
--Vérification
#jps
--http://localhost:50070
--http://localhost:50095
--http://localhost:8088
--http://localhost:8042
#hdfs dfs -mkdir /user
#hdfs dfs -mkdir /user/hduser
#hdfs dfs chown hduser /user/hduser
#hdfs dfs -mkdir data  -- data sera creé dans /user/hduser
#hdfs dfs -mkdir results  -- data sera creé dans /user/hduser

-- Pour installer Sublime txt
#sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
#sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
#sudo yum install sublime-text 