cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
cd ~

yum update
yum install openssh-clients
yum install wget
yum install passwd
yum install which
yum install ncurses

wget https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz
tar -zxvf jdk-8u212-linux-x64.tar.gz
#su
mv jdk1.8.0_212  /usr/java
ls /usr/java
#groupadd hadoop
#adduser  -G hadoop hduser
#passwd hduser
#su - hduser

wget https://archive.apache.org/dist/hadoop/core/hadoop-2.9.2/hadoop-2.9.2.tar.gz
tar xzf hadoop-2.9.2.tar.gz

#su
mv hadoop-2.9.2 /opt/hadoop
ls /opt/hadoop
#su - hduser

