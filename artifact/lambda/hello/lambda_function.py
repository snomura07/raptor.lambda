import boto3

def lambda_handler(event, context):
    print("Hello from Lambda!")
    return {
        'statusCode': 200,
        'body': 'Lambda executed successfully!!'
    }
