#!/bin/sh

while getopts n:q: flag
do
    case "${flag}" in
        n) NAME=${OPTARG};;
        q) QUOTE=${OPTARG};;
    esac
done

aws dynamodb put-item \
--region us-east-1 \
--table-name moo \
--item '{"id": {"S": "moo"}, "sk": {"S": "'$(uuid)'"}, "value": {"M": {"name": {"S": "'"$NAME"'"}, "quote": {"S": "'"$QUOTE"'" }}}}'
