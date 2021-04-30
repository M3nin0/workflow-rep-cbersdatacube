install_reprocli:
	git clone https://github.com/M3nin0/experiment-reproducible-research-portal.git
	cd experiment-reproducible-research-portal/tool \
		&& python3 setup.py install \
		&& rm -rf experiment-reproducible-research-portal

ingest:
	reprocli ingest --compendium $$compendium \
		--invenio-access-token $$token \
		--invenio-service-url $$url
