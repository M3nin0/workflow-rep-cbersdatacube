SHELL := /bin/bash

check:
	if [ -z "${BDC_ACCESS_TOKEN}" ]; then echo "É preciso definir a variável de ambiente BDC_ACCESS_TOKEN" && exit 2; fi

clone:
	git clone https://github.com/M3nin0/experiment-rep-cbersdatacube.git

clean:
	rm -rf venv

workflow: check clone
	cd experiment-rep-cbersdatacube \
		&& make replicate 
