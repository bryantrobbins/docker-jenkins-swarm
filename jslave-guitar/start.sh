#!/bin/bash

java -jar swarm.jar -master $SWARM_MASTER -username $SWARM_USER -passwordEnvVariable SWARM_PASSWORD -labels "basic guitar" -executors 1 -fsroot /home/jslave/work
