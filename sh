#!/bin/bash

date > ./1227.log

:<<!
./main1 <<< $'64\n 2\n' > 1227.log 2>/dev/null
./mainh <<< $'64\n 2\n' > 1227.log 2>/dev/null
./mainh2 <<< $'64\n 2\n' > 1227.log 2>/dev/null
!

./main1 <<< $'64\n 1\n' 2>&1 |tee -a ./1227.log
./mainh <<< $'64\n 1\n' 2>&1 |tee -a ./1227.log
./mainh2 <<< $'64\n 1\n' 2>&1 |tee -a ./1227.log

./main1 <<< $'64\n 2\n' 2>&1 |tee -a ./1227.log
./mainh <<< $'64\n 2\n' 2>&1 |tee -a ./1227.log
./mainh2 <<< $'64\n 2\n' 2>&1 |tee -a ./1227.log

./main1 <<< $'128\n 2\n' 2>&1 |tee -a ./1227.log
./mainh <<< $'128\n 2\n' 2>&1 |tee -a ./1227.log
./mainh2 <<< $'128\n 2\n' 2>&1 |tee -a ./1227.log
