FROM centos:7

WORKDIR /root/

RUN yum install bzip2 wget which -y

RUN yum install -y openssh-server openssh-clients && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "root:guojiming" | chpasswd && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \ 
    mkdir /var/run/sshd

COPY jdk-8u121-linux-x64.rpm /root/

RUN cd /root/ && \
    yum install -y jdk-8u121-linux-x64.rpm && \
    export JAVA_HOME=/usr/java/jdk1.8.0_121/ && \
    rm -rf jdk-8u121-linux-x64.rpm    
    
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

