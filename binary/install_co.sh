#! /bin/bash
# install net_speeder

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

dir=/usr/shell
downdir=/usr/src

#决定脚本目录的路径
[[ ! -d $dir  ]] && mkdir $dir

cd $downdir
yum install -y libnet libpcap epel-release wget unzip subversion
svn export svn://vps3.chuixifeng.win/ldh/vps/net-speeder --username ldh --password 12345678 --force
cd net-speeder

if [ `ifconfig venet0 > /dev/null 2>&1` ] ;then
        chmod +x net-speederd_ov						#openvz
		mv net-speederd_ov /etc/init.d
	else
    	chmod +x net-speederd							#kvm,xen,vm,
		mv net-speederd /etc/init.d
	fi
chkconfig --add net-speederd
chkconfig net-speederd on

function compile () {
	yum install -y  libnet-devel libpcap-devel  gcc  > /dev/null 2>&1

	unzip -uq master.zip
	cd net-speeder-master

	if [ `ifconfig venet0 > /dev/null 2>&1` ] ;then
        sh build.sh                                     #openvz
	else
        sh build.sh -DCOOKED                    		#kvm,xen,vm,
	fi
	mv net_speeder /usr/shell/net_speeder64
	
}

function binary () {
	if [ `ifconfig venet0 > /dev/null 2>&1` ] ;then
        mv net_speeder_ov /usr/shell/net_speeder64                          #openvz
		chmod +x /usr/shell/net_speeder64
	else
        mv net_speeder64 /usr/shell/net_speeder64                    		#kvm,xen,vm,
		chmod +x /usr/shell/net_speeder64
	fi
		
}

case "$1" in
  compile)
    compile
    ;;
  binary)
    binary
    ;;
  *)
    echo $"Usage: $0 {compile|binary}"
    exit 2
esac
exit $?