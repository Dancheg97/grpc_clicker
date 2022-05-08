# grpc_rocket

cd ..;cd gRPC_api_example;go run .
grpcurl -proto api.proto -d '{"message": 12.123}' -plaintext localhost:12201 pb.Basics/DoubleCall
grpcurl -import-path . -proto C:\Users\dangd\OneDrive\Документы\gRPC_api_example\api.proto describe

## TODO

- add check if grpcurl installed
- Send grpcurl message to service ``
