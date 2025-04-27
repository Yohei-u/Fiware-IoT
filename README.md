# Fiware-IoT

forward.sh muss angepasst werden, dass der Gerätename in beiden Zeilen, sowie in #sensor übereinstimmt und dass der API Key mit #service group und #sensor übereinstimmt.
Danach "docker compose up" im Kontext der Dockerfile, dann die Befehle aus commands.txt #service group, #sensor und #subscription in einer unix shell ausführen. 
Das Feld "idPattern" aus #subscription und "entity_name" aus #sensor müssen zusammenpassen.
