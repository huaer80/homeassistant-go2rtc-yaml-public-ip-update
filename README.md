# homeassistant-go2rtc-yaml-public-ip-update
To update the candidates IP found in go2rtc.yaml for the go2rtc add-on in homeassistant. Especially in the scenario where you are using dynamic public IP issued by your ISP.

**Pre-requisite**

1) Assuming you have homeassistant running as a docker container.
2) Assuming you have install go2rtc addon into homeassistant.
Note: The (go2rtc addon)[https://github.com/AlexxIT/go2rtc] is [https://github.com/AlexxIT/go2rtc]
3) Assuming the location of the go2rtc configuration file go2rtc.yaml is under the following path /volume1/docker/homeassistant/go2rtc.yaml

**How it works**

1) Perform a curl check to determine your existing public IP.
2) Read and extract the "candidate" IP which should be your existing public IP.
3) Compare both IPs and update the go2rtc.yaml configuration file if the public IP has changed.
4) Restart homeassistant container.

**To configure**

1) Setup a scheduled task/cron job to existing this script as daily/hourly or even in minutes.  Depending on how often your ISP changes the dynamic public IP.
2) Currently, I'm only running this script on a daily basis.

**To Do**

1) NA.
