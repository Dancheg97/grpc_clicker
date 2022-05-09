# <p  align="center" style="font-family:courier;font-size:180%" size=212px> gRPC-Rocket </p>

[![Generic badge](https://img.shields.io/badge/LICENSE-MIT-orange.svg)](LICENSE)

<p align="center">
<img align="center" style="padding-left: 10px; padding-right: 10px; padding-bottom: 10px;" width="138px" height="138px" src="https://cdn-icons-png.flaticon.com/512/762/762658.png" /> 
</p>

gRPC-Rocket is cross-platform application for testing [gRPC](https://grpc.io) API's.

Application is built with [flutter](https://flutter.dev), but under the hood it uses [grpcurl](https://github.com/fullstorydev/grpcurl).

Currently supported features:

- Api schema parser
- Body autofilling
- Request history
- Requests as json's
- Request body caching
- Request body saving

Not supported features:

- gRPC streams
- complex bodies

## TODO

- add check if grpcurl installed
- Send grpcurl message to service ``
