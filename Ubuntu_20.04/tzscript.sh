# set noninteractive installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get install -y -q
#export DEBIAN_FRONTEND=noninteractive
#install tzdata package
apt-get install -y tzdata
# set your timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata