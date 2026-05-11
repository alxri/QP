# Makefile for ZCU104 PYNQ native compilation (C with libcma)

CC = gcc
CFLAGS = -O3 -Wall -std=gnu11
LDFLAGS = -lcma -lm -lrt

TARGET = admm_test
SRC = admm_test.c

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

clean:
	rm -f $(TARGET)