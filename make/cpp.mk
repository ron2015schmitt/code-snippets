

CC:=gcc
CFLAGS:= -Wall -Wextra -Wpedantic -std=gnu11
#-std=c11
#-D_POSIX_C_SOURCE=200809L
SHELL:=/bin/bash
PWD := $(shell pwd)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

%.i: %.c
	$(CC) $(CFLAGS) -S -save-temps  $< 
