

### Getting Started
#### Clone Repository
```
git clone https://github.com/kroolar/geo.git
```

#### Access Key
To use all features of the App you have to provide your API KEY for IP Stack.
Access key is defined in `./docker-compose.yml:19`

If you don't provide an API key you can still use the app, but some features will be limited.

#### Run Application
``` bash
# It will run rails application and MySQL server 
docker compose up
```

### Usage
#### Endpoints
There are three main endpoint that allow you create, read and delete specific geolocation.
- `GET    /v1/geolocations/:address`
- `POST   /v1/geolocations/:address`
- `DELETE /v1/geolocations/:address`

#### Address
Address can be defined as an IP or URL. Below list of valid addresses/
- 157.240.229.35
- domain.com
- www.domain.com
- http://domain.com
- https://domain.com
- http://www.domain.com
- https://www.domain.com

#### Seed Data
Application comes with pre-defined geolocations. If you would like to use them you can find them in `./db/seeds.rb`.
