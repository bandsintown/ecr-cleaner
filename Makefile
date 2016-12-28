PROJECT_NAME=ecr-cleaner
VERSION=v0.5

all: bin

bin:
	GOARCH=amd64 GOOS=linux go build -o bin/linux/$(PROJECT_NAME)
	
clean:
	rm -rf bin

test:
	go test

release: clean bin
	hub release create -a "bin/linux/$(PROJECT_NAME)" -m "$(VERSION)" "$(VERSION)"

package: clean bin
	zip -j main.zip bin/linux/ecr-cleaner python/index.py