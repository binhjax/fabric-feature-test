# Config Fabric Network notes

_1. Run peer as system service

    1. copy file deploy/peer*.service into path /etc/systemd/system/  
    2. restart service
    Note:
        StandardOutput, StandardError: log as syslog
        SyslogIdentifier: programname when using syslog

_2. Send syslog of service to graylog

    1. copy file deploy/graylog.conf into path /etc/rsyslog.d/
    2. restart rsyslog: sudo service rsyslog restart
    Note:
        - The if statement filter the program name before sending
        - Can add multiple output before &stop. For example: 
            if $programname == 'peer' then /var/log/test.log


_3. Send syslog of chaincode to graylog

    Update LogConfig in core as following:
        LogConfig:
            Type: gelf
            Config:
                gelf-address: udp://10.22.7.239:12201

