#!/bin/bash
cd ~/Documents;
wget https://github.com/oflynned/CronSnapper/archive/master.zip;
unzip master.zip -d 'Files';
cd Files/CronSnapper-master;
cp -rf * ..;
cd ..;
rm -rf CronSnapper-master;
cd ..;
rm -rf master.zip; 
cd Files;
./cron_job.sh;
