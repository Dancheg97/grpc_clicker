
server:
	cd ..;cd gRPC_api_example;go run .

call:
	grpcurl -proto api.proto -d '{"message": 12.123}' -plaintext localhost:12201 pb.Basics/DoubleCall

descr:
	grpcurl -import-path . -proto C:\Users\dangd\OneDrive\Документы\gRPC_api_example\api.proto describe

