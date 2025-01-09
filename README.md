# Fiware-IoT

#mosquitto testing setup
docker exec -it 58f17d6dffacf84a269ed455c2d93682050a9d3a9afb186313e24494576c114a ash
docker start 58f17d6dffacf84a269ed455c2d93682050a9d3a9afb186313e24494576c114a

mosquitto_sub -t shellies/shellyht-749A22/sensor/temperature

#recast
mosquitto_sub -t shellies/shellyht-749A22/sensor/temperature | while read -r message
do
    mosquitto_pub -t ut/apiKey/shellyht-749A22/attrs -m "t|$message" -h mosquitto
done

#test recast
mosquitto_sub -t ut/apiKey/shellyht-749A22/attrs

#mqtt config
allow_anonymous true
listener 1883 0.0.0.0

#service group
curl -iX POST \
  'http://localhost:4041/iot/services' \
  -H 'Content-Type: application/json' \
  -H 'fiware-service: openiot' \
  -H 'fiware-servicepath: /' \
  -d '{
 "services": [
   {
     "apikey":      "apiKey",
     "cbroker":     "http://orion:1026",
     "entity_type": "Thing",
     "resource":    ""
   }
 ]
}'

#sensor
curl -iX POST \
  'http://localhost:4041/iot/devices' \
  -H 'Content-Type: application/json' \
  -H 'fiware-service: openiot' \
  -H 'fiware-servicepath: /' \
  -d '{
 "devices": [
   {
     "device_id":   "shellyht-749A22",
     "entity_name": "urn:ngsi-ld:Temp:001",
     "entity_type": "Temp",
     "protocol":    "PDI-IoTA-UltraLight",
     "transport":   "MQTT",
     "timezone":    "Europe/Berlin",
     "attributes": [
       { "object_id": "t", "name": "temperature", "type": "Float" }
     ]
   }
 ]
}
'

#show all devices
curl -G -X GET \
  'http://localhost:1026/v2/entities/' \
  -H 'fiware-service: openiot' \
  -H 'fiware-servicepath: /'
