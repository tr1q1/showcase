## import urllib.request
## import json      
## 
## data = {'number': '+34656278569', 'message': 'PRUEBA 1 INDEPENDIENTE desde Python'} ##, 'token': '2GsJKOLK5R'}     # Set POST fields here
## url = 'http://172.17.50.94:8766' # Set destination URL here
## 
## jsondata = json.dumps(data)
## jsondataasbytes = jsondata.encode('ISO-8859-1')   # needs to be bytes
## print (jsondataasbytes)
## 
## req = urllib.request.Request(url)
## req.add_header('Content-Type', 'application/json; charset=ISO-8859-1')
## req.add_header('Content-Length', len(jsondataasbytes))
## 
## response = urllib.request.urlopen(req, jsondataasbytes, timeout=10) 
## print(respons

from urllib import request as urlrequest

proxy_host = 'auditorias:auditorias@proxy.andrade.einsanet.es:8080'    # host and port of your proxy
url = 'http://172.17.50.94:8766/'

req = urlrequest.Request(url)
req.set_proxy(proxy_host, 'http')

response = urlrequest.urlopen(req)
print(response.read().decode('utf8'))