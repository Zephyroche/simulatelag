## **Usage**
You need edit parameters at the start of the script to specify the network interface and IP address. <br /> IP and interface name should be without ""
```
IF="eth" #Your interface name
DST_CIDR="ip" #Address to apply lag on
```
Then, you need to run as root something like
```
simulatelag.sh start 15
```
And get this message
```
 LOSS : 15%
```
This will simulate loss 15% for all packets going to ***DST_CIDR*** via ***IF*** 
