apt-get update -y
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 80
sudo ufw allow 443
lam='\033[1;34m'        
tim='\033[1;35m'
bash <(curl -Ls https://raw.githubusercontent.com/ht4g/xrayx/main/install.sh)
read -p " NODE ID Cong 80: " node_id1
  [ -z "${node_id1}" ] && node_id1=0
  
read -p " NODE ID ng 443: " node_id2
  [ -z "${node_id2}" ] && node_id2=0
rm -rf /etc/XrayR/ht4g.crt
rm -rf /etc/XrayR/ht4g.key
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/XrayR/ht4g.crt -keyout /etc/XrayR/ht4g.key -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku/O=Google Trust Services LLC/CN=google.com"
cd /etc/XrayR
cat >config.yml <<EOF
Log:
  Log:
  Level: none 
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json
InboundConfigPath: # /etc/XrayR/custom_inbound.json
RouteConfigPath: # /etc/XrayR/route.json
OutboundConfigPath: # /etc/XrayR/custom_outbound.json
ConnectionConfig:
  Handshake: 4 
  ConnIdle: 30 
  UplinkOnly: 2 
  DownlinkOnly: 4 
  BufferSize: 64 
Nodes:
  -
    PanelType: "V2board" 
    ApiConfig:
      ApiHost: "https://maxspeed4g.site"
      ApiKey: "dddvn12345678999"
      NodeID1: 1
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0
      DeviceLimit: 0
      RuleListPath: # /etc/XrayR/rulelist
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 
      SendIP: 0.0.0.0 
      UpdatePeriodic: 60 
      EnableDNS: false 
      DNSType: AsIs 
      EnableProxyProtocol: false 
      EnableFallback: false 
      FallBackConfigs:  
        -
          SNI: 
          Path: 
          Dest: 80 
          ProxyProtocolVer: 0 
      CertConfig:
        CertMode: file 
        CertDomain: "test.maxspeed4g.site" 
        CertFile: /etc/XrayR/speed4g.crt
        KeyFile: /etc/XrayR/speed4g.key
        Provider: cloudflare 
        Email: lole7176@gmail.
        DNSEnv: 
          CLOUDFLARE_EMAIL:
          CLOUDFLARE_API_KEY:
  -
    PanelType: "V2board" 
    ApiConfig:
      ApiHost: "https://maxspeed4g.site"
      ApiKey: "dddvn12345678999"
      NodeID2: 1
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0
      DeviceLimit: 0
      RuleListPath: # /etc/XrayR/rulelist
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 
      SendIP: 0.0.0.0 
      UpdatePeriodic: 60 
      EnableDNS: false 
      DNSType: AsIs 
      EnableProxyProtocol: false 
      EnableFallback: false 
      FallBackConfigs:  
        -
          SNI: 
          Path: 
          Dest: 80 
          ProxyProtocolVer: 0 
      CertConfig:
        CertMode: file 
        CertDomain: "MAXSPEED4G.SITE" 
        CertFile: /etc/XrayR/ht4g.crt 
        KeyFile: /etc/XrayR/ht4g.key
        Provider: cloudflare 
        Email: lole7176@gmail.com
        DNSEnv: 
          CLOUDFLARE_EMAIL: 
          CLOUDFLARE_API_KEY: 
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./config.yml
sed -i "s|NodeID2:.*|NodeID: ${node_id2}|" ./config.yml
cd /root && xrayr restart && clear && echo -e "   Cai dat hoan tat!"
#Speedtest
sudo apt-get install curl
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
clear
echo -e "${lam}【KIEM TRA TOC DO  VPS】${tim}"
speedtest
