#!/usr/bin/env python3.9

# https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html

import os
import random
import json

# https://awslabs.github.io/aws-lambda-powertools-python/latest/
from aws_lambda_powertools.utilities import parameters

def random_quote():
    dynamodb_provider = parameters.DynamoDBProvider(table_name=os.environ['DB_TABLE_NAME'])
    quotes = dynamodb_provider.get_multiple(os.environ['DB_TABLE_HASH_KEY'])
    return json.dumps(random.choice(list(quotes.items())))

def handler(event, context):
    quote = json.loads(random_quote())
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(quote)
    }
