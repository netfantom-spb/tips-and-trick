# tcpdump - dump traffic on network

## dump traffic with given hostname
```
tcpdump hostname 127.0.0.1
```

## dump to the file
```
tcpdump hostname 127.0.0.1 -w dump.pcap
```


## limit by time (in seconds from the first packet)
```
tcpdump hostname 127.0.0.1 -w dump.pcap -G 3600 -W 1
```
or
```
timeout 3600 tcpdump hostname 127.0.0.1 -w dump.pcap
```