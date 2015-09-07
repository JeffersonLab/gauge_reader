PROJ = readGauge

LIBS += $(shell pkg-config opencv libconfig --libs) -lm
CFLAGS += -Wall
CFLAGS += -O2
CFLAGS += $(shell pkg-config opencv libconfig --cflags)
CC = g++


$(PROJ) : $(PROJ).C
	$(CC) -o $@ $(CFLAGS) $(LIBS) $<

clean :
	-rm -f $(PROJ)
