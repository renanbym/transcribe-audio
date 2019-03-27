package main

import (
	"bytes"
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response events.APIGatewayProxyResponse

func handler(context context.Context, request events.APIGatewayProxyRequest) (Response, error) {
	fmt.Println("Received body: ", request.Body)

	var buf bytes.Buffer

	resp := Response{
		StatusCode: 200,
		Body:       buf.String(),
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
	}

	return resp, nil
}

func main() {
	lambda.Start(handler)
}
