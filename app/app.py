#!/usr/bin/env python3.9

# https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html

import random
# import cowsay # https://pypi.org/project/cowsay # add to requirements.txt

# https://awslabs.github.io/aws-lambda-powertools-python/latest/
# from aws_lambda_powertools.utilities import parameters # add aws-lambda-powertools to requirements.txt

def random_quote(quote_file):
    # quote_lines = open('file.txt').read().splitlines()
    # quote = random.choice(quote_lines)
    quote = next(quote_file)
    for num, quote_line in enumerate(quote_file, 2):
        if random.randrange(num):
            continue
        quote = quote_line
    return quote.split('|')

def handler(event, context):
    quote = random_quote(open("quotes.txt"))
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": {
            "name": quote[0],
            "quote": quote[1].strip()
        }
    }
