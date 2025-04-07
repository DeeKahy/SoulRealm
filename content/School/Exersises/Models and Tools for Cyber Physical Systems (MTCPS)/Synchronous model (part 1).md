
![[Pasted image 20250407143139.png]]
√

![[Pasted image 20250407143257.png]]
√

![[Pasted image 20250407143312.png]]
√

![[Pasted image 20250407143335.png]]
10 i think

![[Pasted image 20250407143345.png]]
UPPAAL says it is.



## task 2
![[Pasted image 20250407143619.png]]

```mermaid
flowchart LR

boolIN --> x(if y)
x -->|true| x1(out = x)
x -->|false| x2(out = 0)
x1 --> x3(x = in)
x2 --> x3
x3 --> invertY(y = !y)


```

```mermaid
flowchart LR

start(bool x = 0) -.-> O
O(0) -->|out:= 0; x:=in| I(1)
I -->|out:=x; x:=in| O
```
What exactly happens here?

