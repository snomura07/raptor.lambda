.PHONY: zip deploy invoke clean

zip:
	cd src && zip -r ../lambda.zip .

deploy: zip
	awslocal lambda create-function \
		--function-name HelloLambda \
		--runtime python3.11 \
		--handler lambda_function.lambda_handler \
		--role arn:aws:iam::000000000000:role/fake-role \
		--zip-file fileb://lambda.zip || echo "Function already exists"

invoke:
	awslocal lambda invoke \
		--function-name HelloLambda \
		--payload '{}' \
		response.json && cat response.json

clean:
	rm -f lambda.zip response.json
