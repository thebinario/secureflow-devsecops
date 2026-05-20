FROM golang:1.22 AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -o secureflow-go-fixture .

FROM alpine:3.20

WORKDIR /app

COPY --from=build /app/secureflow-go-fixture ./

ENTRYPOINT ["./secureflow-go-fixture"]
