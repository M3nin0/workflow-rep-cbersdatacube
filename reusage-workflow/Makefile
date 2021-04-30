SHELL := /bin/bash

check:
	if [ -z "${BDC_ACCESS_TOKEN}" ]; then echo "É preciso definir a variável de ambiente BDC_ACCESS_TOKEN" && exit 2; fi

environment:
	python3 -m venv venv
	source venv/bin/activate \
		&& pip install \
		cwltool==3.1.20210426140515 \
		cwlref-runner==1.0 \
		wheel==0.36.2

clone:
	git clone --branch rep-bdc-article https://github.com/M3nin0/experiment-rep-cbersdatacube.git

clean:
	rm -rf venv

workflow: check environment clone
	source venv/bin/activate \
		&& cd experiment-rep-cbersdatacube \
		&& make replicate 
