



get a request from a server (with some id as a argument)

then you basically set "available" boolean to zero and when another request comes in you respond in the negative, put them into a queue, then when that first server returns with that they are done then you should set available into true again and then back to false because the other server requested to use it. 


so its a queueing system on when a certain service is available basically.

