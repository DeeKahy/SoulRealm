
Q: Write the exact conversion formula between Unix time and Iso 8601

```py

def is_leap_year(year):
    # 1. Divisible by 4
    # 2. If divisible by 100, must also be divisible by 400
    return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)


def unix_to_iso8601(unix_timestamp):
    # Days in each month for non-leap and leap years
    days_in_month =      [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    days_in_month_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    # Convert to integer seconds
    seconds = int(unix_timestamp)

    # Calculate days since Unix epoch (Jan 1, 1970)
    days_since_epoch = seconds // 86400  # 86400 seconds in a day
    remaining_seconds = seconds % 86400

    # Calculate hours, minutes, seconds
    hours = remaining_seconds // 3600
    remaining_seconds %= 3600
    minutes = remaining_seconds // 60
    secs = remaining_seconds % 60

    # Start from Unix epoch: January 1, 1970
    year = 1970
    days_remaining = days_since_epoch

    # Calculate the year
    while True:
        is_leap = is_leap_year(year)
        days_in_year = 366 if is_leap else 365

        if days_remaining >= days_in_year:
            days_remaining -= days_in_year
            year += 1
        else:
            break

    # Calculate the month and day
    month = 1
    month_days = days_in_month_leap if is_leap_year(year) else days_in_month

    while days_remaining >= month_days[month - 1]:
        days_remaining -= month_days[month - 1]
        month += 1

    day = days_remaining + 1  # Days are 1-indexed

    # Format as ISO 8601
    return f"{year:04d}-{month:02d}-{day:02d}T{hours:02d}:{minutes:02d}:{secs:02d}Z"


# Example usage and tests
if __name__ == "__main__":
    known_conversions = [
        (1577836800, "2020-01-01T00:00:00Z"),  # New Year 2020
        (1609459200, "2021-01-01T00:00:00Z"),  # New Year 2021
        (1234567890, "2009-02-13T23:31:30Z"),  # Famous Unix timestamp
    ]

    for unix_ts, expected_iso in known_conversions:
        calculated_iso = unix_to_iso8601(unix_ts)

        print(f"Expected: {expected_iso}")
        print(f"Got:      {calculated_iso}")
        print(f"Match:    {'√' if calculated_iso == expected_iso else '!='}")
        print()

```



Q: Give (at least) one reason why not to just switch all timing information regarding software, computers, and distributed systems on the ISO 8601 time.

Because UTC is the good time format thats just one long number and you can easily convert to whatever you need.




Q: Assume that the function currentTime() returns the time of your system, which periodically updates via an NTP server and that the function fun() takes 50ms to run on your machine. You run the following code: 
	long startTime = System.currentTime(); 
	fun();
	long endTime = System.currentTime(); 
	long elapsedTime = endTime-startTime; 
Give bounds on elapsedTime. 

1000s + 50ms or 1000s - 50ms depending on if you are ahead of behind



Q: Calculate all the happens-before pairs in the Lamport diagrams on slides 20 and 21. 





Q: Prove that for two events a and b in a distributed system, Either a -> b, b ->a, or a || b. 






Q: A relation R is a strict partial order if it is irreflexive (not exists event a such that (a,a) is in R) and transitive
(for any events a, b, c : if (a,b) in R and (b,c) in R implies (a;c) in R). (These two conditions also imply that it R asymmetric,
i.e. that for any events a,b, if (a,b) in R then (b,a) not in R.) Prove that the happens-before relation is a strict partial order.
Hints: You need to prove the two conditions(irreflexive, transitive) separately from the definition of happens-before. To prove some of them you may need to assume that any two nodes are a nonzero distance apart, as well as the physical principle that information cannot travel faster than the speed of light. 







Q: Assume an NTP client which at time t1 = 3:31am sends a request to an NTP server, which arrives at time 3:30 (at the server side). The server then responds with a message "response(3:31, 3:30, 3:31), which is received by the NTP client at time 3:34. What is the estimated network delay, and what is the estimated clock skew of the client? 
Discuss what would a clock correction look like based on the skew you calculated. 

round tip 2 minutes?



Q: 
In a fail-stop model, which of the following properties are safety
properties?
1. every process that crashes is eventually detected; <-- liveness?
2. no process is detected as crashed before it crashes; <-- safety
3. no two processes decide on a final value differently; <-- safety
4. no two correct(that never crash) processes on a final value decide differently; <-- kinda both?
5. every correct process decides before t time units; <-- safety
6. if some correct process decides then every correct process decides. <-- liveness?


### Safety Properties
Properties that state "something bad never happens" - can be violated in finite time

### Liveness Properties  
Properties that state "something good eventually happens" - require infinite time to verify
