package main

//+build tools

// makes `go run github.com/davecheney/godoc2md` work.

import (
	_ "github.com/davecheney/godoc2md"
)
