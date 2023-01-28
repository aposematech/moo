#!/bin/sh

while getopts r:t:n:q: flag
do
    case "${flag}" in
        r) REGION=${OPTARG};;
        t) TABLE=${OPTARG};;
        n) NAME=${OPTARG};;
        q) QUOTE=${OPTARG};;
    esac
done

aws dynamodb put-item \
--region $REGION \
--table-name $TABLE \
--item '{"id": {"S": "'"$TABLE"'"}, "sk": {"S": "'$(uuid)'"}, "value": {"M": {"name": {"S": "'"$NAME"'"}, "quote": {"S": "'"$QUOTE"'" }}}}'
