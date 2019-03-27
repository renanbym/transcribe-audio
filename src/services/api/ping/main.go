package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response events.APIGatewayProxyResponse

func handler(context context.Context, request events.APIGatewayProxyRequest) (Response, error) {
	fmt.Println("Received body: ", request)
	fmt.Println("Received context: ", context)

	var buf bytes.Buffer

	body, err := json.Marshal(map[string]interface{}{
		"pong": "go",
	})
	if err != nil {
		return Response{StatusCode: 404}, err
	}
	json.HTMLEscape(&buf, body)

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
