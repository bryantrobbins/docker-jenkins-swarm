#!/bin/bash

docker run -v `pwd`:/workdir -w /workdir bryantrobbins/jslave-latex ls -ltr
