package main

import "testing"

func TestGreet(t *testing.T) {
	name := "Jane"
	want := "Hello Jane"
	got := Greet(name)
	if got != want {
		t.Errorf("Greet(%s) = %s; expected %s", name, got, want)
	}
}
