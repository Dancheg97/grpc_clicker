# <p  align="center" style="font-family:courier;font-size:180%" size=212px> gRPC-Rocket </p>

[![Generic badge](https://img.shields.io/badge/LICENSE-MIT-orange.svg)](LICENSE)

<p align="center">
<img align="center" style="padding-left: 10px; padding-right: 10px; padding-bottom: 10px;" width="138px" height="138px" src="https://cdn-icons-png.flaticon.com/512/762/762658.png" /> 
</p>

gRPC-Rocket is cross-platform application for testing [gRPC](https://grpc.io) API's.

Application is built with [flutter](https://flutter.dev), but under the hood it uses [grpcurl](https://github.com/fullstorydev/grpcurl).

To use this application you have to have `grpcurl` installed on your machine, which can be done with command (if you have go language installed):

```cmd
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
```

## Installing

TODO explain

## Using

TODO show example

### Currently supported features:

- Api schema parser
- Body autofilling
- Request history
- Requests as json's
- Request body caching
- Request body saving

### Not supported features:

- gRPC streams
- complex bodies
- tests and tests groups

# TODO

- add proto requst description to top of sending body