![[Pasted image 20250408195024.png]]
www.example.com and example.com are not the same because www is just a subdomain. 

port 4000 and 5000 are not the same origin since (???)

the part after the domain and port is the same origin, thats literally how websites work.

port 81 and port 80 (http) are not the same.

port 443 (https) and http (80) are not the same.


Security is fun. make sure you do stuff properly
- the user is the enemy
- sanitise your data
- properly protect your routes
- protect your api
- Use a proper cryptographic library
- dont push your tokens
