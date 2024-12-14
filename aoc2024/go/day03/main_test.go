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
			name: "Day 03 part 01 Test",
			args: args{
				name: "test1.txt",
			},
			want: 161,
		},
		{
			name: "Day 03 part 01 Input",
			args: args{
				name: "inp1.txt",
			},
			want: 168539636,
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
			name: "Day 03 part 02 Test",
			args: args{
				name: "test2.txt",
			},
			want: 48,
		},
		{
			name: "Day 03 part 02 Input",
			args: args{
				name: "inp1.txt",
			},
			want: 97529391,
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
