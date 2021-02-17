# Run docker-compose as service

1. Put your docker-compose.yml to /opt/my

2. Prepare file /opt/my/my.service
```
[Unit]
Description=My service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
StandardError=null
StandardOutput=null
WorkingDirectory=/opt/my
ExecStart=/usr/bin/docker-compose up -d
ExecStop=/usr/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

3. Enable service
```
sudo systemctl enable /opt/my/my.service
```

4. Start service
```
> sudo systemctl start my
``` 