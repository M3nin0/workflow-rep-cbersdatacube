#!/bin/bash

if [ ! -d "venv" ]; then
    python3 -m venv venv
	source venv/bin/activate \
		&& pip install \
		cwltool==3.1.20210426140515 \
		cwlref-runner==1.0 \
		wheel==0.36.2
fi
