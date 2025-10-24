import json
import boto3
import uuid
import time
import os
from datetime import datetime

dynamodb = boto3.resource(
    'dynamodb',
    endpoint_url=os.environ.get('DYNAMODB_ENDPOINT_URL')  # Noneなら本番に接続
)
table = dynamodb.Table('RaptorDB')

def lambda_handler(event, context):
    print("Lambdaが呼び出されました")
    print(f"受信イベント: {event}")

    try:
        # API Gateway経由のJSONボディを取得
        body = json.loads(event['body'])

        # 必要なフィールドを抽出
        log_item = {
            'logId': str(uuid.uuid4()),  # 一意なID
            'process_name': body['process_name'],
            'status': body['status'],
            'timestamp': int(time.time()),
            'date_time':body['date_time']
        }
        print(f"log item: {log_item}")

        # DynamoDBに保存
        table.put_item(Item=log_item)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Log saved', 'logId': log_item['logId']})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
