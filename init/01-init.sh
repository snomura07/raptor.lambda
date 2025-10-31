#!/bin/bash
set -e

NAME="hello"

echo "start $NAME Lambda init script"
cd /workspace

make create-$NAME

API_ID=$(awslocal apigateway create-rest-api --name $NAME-api --query 'id' --output text)
ROOT_ID=$(awslocal apigateway get-resources --rest-api-id $API_ID --query 'items[0].id' --output text)
RESOURCE_ID=$(awslocal apigateway create-resource \
  --rest-api-id $API_ID \
  --parent-id $ROOT_ID \
  --path-part $NAME \
  --query 'id' --output text)

awslocal apigateway put-method \
  --rest-api-id $API_ID \
  --resource-id $RESOURCE_ID \
  --http-method GET \
  --authorization-type "NONE"

awslocal apigateway put-integration \
  --rest-api-id $API_ID \
  --resource-id $RESOURCE_ID \
  --http-method GET \
  --type AWS_PROXY \
  --integration-http-method POST \
  --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:$NAME/invocations

awslocal apigateway create-deployment \
  --rest-api-id $API_ID \
  --stage-name dev

echo "${NAME}_API_ID=$API_ID" >> /workspace/ids
echo "${NAME}_ROOT_ID=$ROOT_ID" >> /workspace/ids

export ${NAME}_API_ID=$API_ID
export ${NAME}_ROOT_ID=$ROOT_ID