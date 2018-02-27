#!/bin/bash

export PORT=5103

cd ~/www/tasktracker2
./bin/tasktracker2 stop || true
./bin/tasktracker2 start
