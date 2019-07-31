
userHunt3rh
===========

Find user accounts on the net!!. Using the great OSINT info tools to recon USERNAMES!
OSINT USERNAMES.

Tested on Kali.

In folder installers run 
* **kali**: ```# chmod 770 *.sh   ```
* **kali**: ```# ./init-install.sh   ```

# How to use:

* **kali**: ```# ./userHunt3rh.sh   ```

for the more paranoid --- use tor takes longer . to setup tor sock check bottom of readme file

* **kali**: ```# ./userHunt3rh-tor.sh   ```

choose option "b"

you will need to submit username 

example : dick.tracey

![Example](https://imgur.com/Ld6ZQGo.png)
![Example](https://imgur.com/nuBehIE.png)
![Example](https://imgur.com/6QDgrI5.png)
Also do :
https://gist.github.com/DusanMadar/c1155329cf6a71e4346cae271a2eafd3

This will config tor port.
# A step-by-step guide how to use Tor without Authentication

Tested on Ubuntu 16.04 Docker container. The Dockerfile is a single line `FROM ubuntu:16.04`.

NOTE: stopping services didn't work for me for some reason. That's why there is `pidof <service name> | xargs kill` after each failed `service <service name> stop` to kill it.

## References
* [How to request new TOR identity in terminal](https://stackoverflow.com/q/16987518/4183498)
* [How to anonymize the programs from your terminal with torify](https://linuxaria.com/howto/how-to-anonymize-the-programs-from-your-terminal-with-torify)
* [How To: Using Tor From The Command Line](https://justhackerthings.com/post/using-tor-from-the-command-line/)
* [How to change Tor identity in Python?](https://stackoverflow.com/q/9887505/4183498)
* [Control Port telnet AUTHENTICATE without any password](https://tor.stackexchange.com/q/14146)
* [Tor IP changing and web scraping](https://dm295.blogspot.com/2016/02/tor-ip-changing-and-web-scraping.html)

## Related
* [A step-by-step guide how to use Python with Tor and Privoxy](https://gist.github.com/DusanMadar/8d11026b7ce0bce6a67f7dd87b999f6b)


## Steps

### 1. Install and check Tor status
```console
root@75f6721089f2:/# apt update
root@75f6721089f2:/# apt install tor
root@75f6721089f2:/# service tor status
 * tor is not running
 ```

### 2. Start Tor and check it's running
```console
root@75f6721089f2:/# service tor start 
 * Starting tor daemon...          [ OK ] 
root@75f6721089f2:/# service tor status
 * tor is running
```

### 3. Try to Authenticate with nc (Netcat)
It's not possible to connect as `ControlPort` is not set yet.
```console
root@75f6721089f2:/# apt install netcat
root@75f6721089f2:/# echo -e 'AUTHENTICATE' | nc 127.0.0.1 9051
(UNKNOWN) [127.0.0.1] 9051 (?) : Connection refused
```

### 4. Stop/kill Tor, set ControlPort and start Tor again
```console
root@75f6721089f2:/# service tor stop
 * Stopping tor daemon...          [fail]
root@75f6721089f2:/# pidof tor | xargs kill
root@75f6721089f2:/# service tor status
 * tor is not running
root@75f6721089f2:/# echo "ControlPort 9051" >> /etc/tor/torrc
root@75f6721089f2:/# service tor start 
 * Starting tor daemon...          [ OK ] 
```

### 5. Try to Authenticate with nc again
It's possible to connect but Authentication fails.
```console
root@75f6721089f2:/# echo -e 'AUTHENTICATE' | nc 127.0.0.1 9051
515 Authentication failed: Wrong length on authentication cookie.
```

### 6. Stop/kill Tor, turn off `CookieAuthentication` and start Tor again
```console
root@75f6721089f2:/# service tor stop
 * Stopping tor daemon...          [fail]
root@75f6721089f2:/# pidof tor | xargs kill
root@75f6721089f2:/# echo "CookieAuthentication 0" >> /etc/tor/torrc
root@75f6721089f2:/# service tor start
 * Starting tor daemon...
Jan 20 11:34:30.911 [warn] ControlPort is open, but no authentication method has been configured. 
                           This means that any program on your computer can reconfigure your Tor.
                           That's bad!
                           You should upgrade your Tor controller as soon as possible.
                    [ OK ] 
```

### 7. Try to Authenticate with nc again
Authentication passes.
```console
# NOTE Use Ctrl+C to exit.
root@75f6721089f2:/# echo -e 'AUTHENTICATE' | nc 127.0.0.1 9051
250 OK
```

### 8. Check your public IP and currently used Tor ip
```console
root@75f6721089f2:/# apt install curl
root@75f6721089f2:/# curl http://icanhazip.com/ 
89.196.159.79
root@75f6721089f2:/# torify curl http://icanhazip.com/   
185.220.101.17
```


### 9. Change and check Tor IP
```console
root@75f6721089f2:/# echo -e 'AUTHENTICATE\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
250 OK
250 OK
250 closing connection
root@75f6721089f2:/# torify curl http://icanhazip.com/
185.220.101.6
```

### 10. Change (with Python3) and check Tor IP
```console
root@75f6721089f2:/# apt install python3
root@75f6721089f2:/# apt install python3-pip
root@75f6721089f2:/# pip3 install stem
root@75f6721089f2:/# python3
```
```python
>>> from stem import Signal
>>> from stem.control import Controller
>>> 
>>> with Controller.from_port(port=9051) as controller:
...     controller.authenticate()
...     controller.signal(Signal.NEWNYM)
... 
>>> 
```
```console
root@75f6721089f2:/# torify curl http://icanhazip.com/
185.107.81.233
```


