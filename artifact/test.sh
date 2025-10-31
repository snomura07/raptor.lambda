#!/bin/bash

echo "start test script"

NAME="hello"
echo "invoke lambda function: $NAME"

eval TES_${NAME}="ok"

echo TES_${NAME}