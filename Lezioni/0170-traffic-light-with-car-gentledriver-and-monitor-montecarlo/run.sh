#!/bin/sh

omc +std=3.3 build.mos

./System -override stopTime=2

#omc +std=3.3 simulate.mos

omc +std=3.3 plot.mos
