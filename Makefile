
LIBS += $(shell pkg-config opencv libconfig --libs) -lm
CFLAGS += -Wall
CFLAGS += -O2
CFLAGS += $(shell pkg-config opencv libconfig --cflags)
CC = g++

all : readGauge.C
	$(CC) -o readGauge $(CFLAGS) $(LIBS) $<

clean :
	-rm -f readGauge
