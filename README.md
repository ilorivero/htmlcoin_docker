# Build HTMLCoin Docker Images for Ubuntu 18.04 Bionic and 20.04 Focal


## HTMLCoin Docker dockerfile and scripts

This repository contains the Dockerfile and scripts to build a HTMLCoin node version 2.5 Docker image on Ubuntu 18.04 and 20.04.

Clone this repository with

```
git clone https://github.com/ilorivero/htmlcoin_docker.git
```

## To build the Ubuntu 18.04 Bionic version image:

```bash
cd ./htmlcoin_docker/Ubuntu_18.04/
docker build -t htmlcoin .
```

## To build the Ubuntu 20.04 Focal Fossa version image:

As there is no bitcoin repository for Ubuntu 20.04, I did some workarounds to make it work. 
Added the bionic repository, repository keys and configured time zone for unattended install. 

```bash
cd ./htmlcoin_docker/Ubuntu_20.04/
chmod 777 tzscript.sh
docker build -t htmlcoin .
```

## Create a Docker Volume to store the blockchain data and htmlcoin.conf

This will preserve the blockchain data.

```bash
docker volume create --name=htmlcoin-data
```

## To build and run the container image:

```bash
docker run -d --rm --name htmlcoin -v htmlcoin-data:/root/.htmlcoin/ htmlcoin 
```

To check if the htmlcoin container is running:

```bash
 docker exec -i -t htmlcoin /bin/bash
```

You should be prompted with the Ubuntu command line. 

```bash
root@0670472b9f64:/HTMLCOIN#
```

Check the Ubuntu version:

```bash
lsb_release -a
```

You shoud get something like this:

``` 
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04 LTS
Release:        20.04
Codename:       focal
``` 

To check if HTMLCoin daemon is running, call the htmlcoin-cli app with --getinfo parameter:

```bash
htmlcoin-cli --getinfo
```

The result should be something like this:

```json
{
  "version": 2050000,
  "protocolversion": 70017,
  "blocks": 0,
  "timeoffset": 0,
  "connections": 1,
  "proxy": "",
  "difficulty": {
    "proof-of-work": 2807.914485770511,
    "proof-of-stake": 1879528578.109458
  },
  "chain": "main",
  "moneysupply": 0,
  "walletversion": 169900,
  "balance": 0.00000000,
  "stake": 0.00000000,
  "keypoololdest": 1594231883,
  "keypoolsize": 1000,
  "paytxfee": 0.00000000,
  "relayfee": 0.00400000,
  "warnings": ""
}
```






