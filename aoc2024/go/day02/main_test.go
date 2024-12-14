package main

import (
	"testing"
)

func Test_part01(t *testing.T) {
	type args struct {
		name string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{
			name: "Day 02 part 01",
			args: args{
				name: "test.txt",
			},
			want: 2,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := part01(tt.args.name); got != tt.want {
				t.Errorf("part01() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_part02(t *testing.T) {
	type args struct {
		name string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{
			name: "Day 02 part 01",
			args: args{
				name: "test.txt",
			},
			want: 4,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := part02(tt.args.name); got != tt.want {
				t.Errorf("part02() = %v, want %v", got, tt.want)
			}
		})
	}
}
