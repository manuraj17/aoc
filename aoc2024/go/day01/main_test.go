package main

import (
	"testing"
)

func Test_day01(t *testing.T) {
	type args struct {
		name string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{
			name: "day01-1 test",
			args: args{
				name: "test1.txt",
			},
			want: 11,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := part01(tt.args.name); got != tt.want {
				t.Errorf("day01() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_day02(t *testing.T) {
	type args struct {
		name string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{
			name: "day01-1 test",
			args: args{
				name: "test1.txt",
			},
			want: 31,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := part02(tt.args.name); got != tt.want {
				t.Errorf("day02() = %v, want %v", got, tt.want)
			}
		})
	}
}
