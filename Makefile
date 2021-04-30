SHELL := /bin/bash

environment:
	./install.sh

	source venv/bin/activate \
		&& cd publication-workflow \
		&& make install_reprocli

#
# replicate the CBERS Data Cube article metholody
#
replicate: environment
	source venv/bin/activate \
	&& cd replication-workflow \
		&& make workflow

#
# reuse the ERC created from CBERS Data Cube replication
#
reuse: environment
	source venv/bin/activate \
		&& cd reusage-workflow \
		&& make workflow

#
# Publish replication ERC on Invenio RDM
#
publish_replication:
	source venv/bin/activate \
		&& cd publication-workflow \
		&& make ingest compendium=replication-workflow/experiment-rep-cbersdatacube token=$$token url=$$url
	
#
# Publish reusage ERC on Invenio RDM
#
publish_reusage:
	source venv/bin/activate \
		&& cd publication-workflow \
		&& make ingest compendium=reusage-workflow/experiment-rep-cbersdatacube token=$$token url=$$url
