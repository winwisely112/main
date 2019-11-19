package main

import (
	"context"
	"fmt"
	"os"

	grpc "github.com/winwisely99/main/server/go-server/internal/protocol/grpc"
	v1 "github.com/winwisely99/main/server/go-server/internal/service/v1"
)

func main() {
	if err := grpc.RunServer(context.Background(), v1.NewChatServiceServer(), "3000"); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}
