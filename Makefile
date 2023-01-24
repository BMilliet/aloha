
build:
	cd aloha && swift build
	@echo "executable location => $$(pwd)/aloha/.build/debug/aloha"

release:
	cd aloha && swift build -c release
	@echo "executable location => $$(pwd)/aloha/.build/release/aloha"

start:
	cd aloha && open Package.swift