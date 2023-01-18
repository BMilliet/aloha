
build:
	cd aloha && swift build

release:
	cd aloha && swift build -c release

start:
	cd aloha && open Package.swift