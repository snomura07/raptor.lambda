.PHONY: zip-% deploy-% invoke-% clean

zip-%:
	cd lambda/$* && zip -r ../../$*.zip .

deploy-%: zip-%
	awslocal lambda create-function \
		--function-name $* \
		--runtime python3.11 \
		--handler lambda_function.lambda_handler \
		--role arn:aws:iam::000000000000:role/fake-role \
		--zip-file fileb://$*.zip || echo "Function '$*' already exists"

invoke-%:
	awslocal lambda invoke \
		--function-name $* \
		--payload '{}' \
		response.json && cat response.json

clean:
	rm -f *.zip response.json
