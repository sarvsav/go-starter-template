package main

import (
	"fmt"
	"os"
)

func Greet(name string) string {
	return "Hello " + name
}

func main() {
	fmt.Println(Greet(os.Args[1]))
}
