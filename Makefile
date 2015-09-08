PROJ = readGauge

LIBS   += $(shell PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' pkg-config opencv libconfig --libs) -lm
CFLAGS += $(shell PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' pkg-config opencv libconfig --cflags)
CFLAGS += -Wall
CFLAGS += -O2
CC = g++


$(PROJ) : $(PROJ).C
	$(CC) $(CFLAGS) $(LIBS) $< -o $@

clean :
	-rm -f $(PROJ)
