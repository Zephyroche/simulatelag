## **Usage**
You need edit parameters at the start of the script to specify the network interface and IP address. <br /> IP and interface name should be without ""
```
IF="eth" #Your interface name
DST_CIDR="ip" #Address to apply lag on
```
Then, you need to run as root something like this
```
simulatelag.sh start 15 5
```
And get this message
```
 LOSS : 15%
 CORRUPT : 5%
```
This will simulate loss 15% and corrupt 5% for all packets going to ***DST_CIDR*** via ***IF*** 
