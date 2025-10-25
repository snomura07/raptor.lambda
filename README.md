- lambdaAPIへのPOST
~~~
curl -XPOST "http://localhost:9001/2015-03-31/functions/function/invocations"   -H "Content-Type: application/json"   -d '{"body": "{\"date_time\":\"2025/10/19 08:13:24\",\"process_name\":\"test\",\"status\":\"Wakeup\",\"timestamp\":\"1760829204\"}"}'
~~~

# localstack

## make tool
### create lambda function
~~~
make create-{function name}
~~~

### update lambda function
~~~
make update-{function name}
~~~

### imvoke lambda function
~~~
make invoke-{function name}
~~~

### clean
~~~
make clean
~~~


## Lambda
### docker setting
~~~
environment:
    - SERVICES=lambda
    - DEBUG=1
~~~

### create function
~~~
awslocal lambda create-function \
  --function-name MyFunction \
  --runtime python3.11 \
  --handler lambda_function.handler \
  --zip-file fileb://function.zip \
  --role arn:aws:iam::000000000000:role/fake-role
~~~

### update function
~~~
awslocal lambda update-function-code \
  --function-name MyFunction \
  --zip-file fileb://function.zip
~~~

### invoke
~~~
awslocal lambda invoke \
  --function-name MyFunction \
  response.json
~~~

## S3
### docker setting
~~~
environment:
    - SERVICES=s3
    - DEBUG=1
volumes:
    - ../mount_volume:/var/lib/localstack
~~~

### make bucket
~~~
awslocal s3 mb s3://my-bucket
~~~

### upload
~~~
awslocal s3 cp ./sample.txt s3://my-bucket/sample.txt
~~~

### ls
~~~
awslocal s3 ls s3://my-bucket
~~~

### rm
~~~
awslocal s3 rm s3://my-bucket/sample.txt
~~~
