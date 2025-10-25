.PHONY: zip-% deploy-% invoke-% clean

zip-%:
	cd lambda/$* && zip -r ../../$*.zip .

create-%: zip-%
	awslocal lambda create-function \
		--function-name $* \
		--runtime python3.11 \
		--handler lambda_function.lambda_handler \
		--role arn:aws:iam::000000000000:role/fake-role \
		--zip-file fileb://$*.zip || echo "Function '$*' already exists"

update-%: zip-%
	awslocal lambda update-function-code \
		--function-name $* \
		--zip-file fileb://$*.zip

invoke-%:
	awslocal lambda invoke \
		--function-name $* \
		--payload '{}' \
		response.json && cat response.json

list:
	awslocal lambda list-functions

clean:
	rm -f *.zip response.json
