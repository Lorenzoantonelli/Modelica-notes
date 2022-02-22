#!/bin/sh

omc build.mos

#./System -cpu -override startTime=0,stopTime=20

omc simulate.mos

omc plot.mos

