- lambdaAPIへのPOST
~~~
curl -XPOST "http://localhost:9001/2015-03-31/functions/function/invocations"   -H "Content-Type: application/json"   -d '{"body": "{\"date_time\":\"2025/10/19 08:13:24\",\"process_name\":\"test\",\"status\":\"Wakeup\",\"timestamp\":\"1760829204\"}"}'
~~~
