#!/bin/bash

EXE=readGauge

rm -f "$EXE"

g++ "$EXE".C -o "$EXE" -lm `pkg-config opencv libconfig --cflags --libs` 
