# Security Awareness API

This is the API for an application to help users become more aware of the privacy implications of using the Internet.
The Internet makes life so much easier, but it also puts our privacy and safety at risk. 

## Client IP Information

Every second, there are services running to gather information about every device connected to the Internet.
This means that there is publicly accessable information about your location and the devices in your home (i.e. the services running on these devices).

As the popularity of smart devices increases, it is important to be aware if that device could be displaying information that could make you vulnerable to a cyber attack.

This API uses [Shodan](https://help.shodan.io/the-basics/what-is-shodan), to gather information about the requesting client's IP by using the [Shodan 'host details' API endpoint](https://developer.shodan.io/api#shodan-host-details).

### **GET** `/api/v1/client_info`

Returns host information for the client's IP address.

#### Example Response

This example response is from a client with devices running a Rails server and a Minecraft server.

```json
{
  "ip":"xxx:xxx:xxx:x",
  "isp":"Comcast",
  "location":{
    "region":"MA",
    "country":"United States",
    "city":"Boston",
    "latitude":42.3601,
    "longitude":71.0589
  },
  "vulns":["CVE-2018-15919"],
  "banners":[
    {
      "data":"HTTP/1.1 200 OK\r\nContent-Length: 0\r\n\r\n",
      "port":3000,
      "timestamp":"2020-11-02T22:40:30.131199",
      "hostnames": [],
      "opts": {},
      "os": null
    },
    {
      "data": "Minecraft Server\n\nPlayers: 1 online - 20 maximum\nVersion: Spigot 1.15.0 (protocol 753)\nDescription: ",
      "port": 25565,
      "timestamp": "2020-11-16T03:23:00.426217",
      "hostnames": [
        "somehostname.com"
      ],
      "opts": {
        "minecraft": {
          "players": {
            "sample": [
              {
                "id": "some-id",
                "name": "minecraftWizard883"
              }
            ],
            "max": 20,
            "online": 1
          },
          "version": {
            "protocol": 753,
            "name": "Spigot 1.15.0"
          },
          "description": ""
        }
      },
      "os": null,
      "product": "Minecraft",
      "version": "Spigot 1.16.3"
    },

  ]
}

```

The `banners` key is a list of objects abiding by [Shodan's banner specification](https://developer.shodan.io/api/banner-specification).

All other keys are 1:1 with the [Shodan 'host details' API endpoint](https://developer.shodan.io/api#shodan-host-details).

