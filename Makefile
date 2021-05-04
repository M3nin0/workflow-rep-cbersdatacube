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
# validation
#
validation_build:
	docker build -t "workflow_rep_validation:temp" -f validation-workflow/Dockerfile .

validation_diff_plot: validation_build
	docker run -ti --name workflow_experiment_diff_plot -v ${PWD}:/opt/experiment/ \
		workflow_rep_validation:temp python validation-workflow/difference_plot.py \
		--map1 $$map1 --map2 $$map2 --typeof $$typeof

	docker rm -f workflow_experiment_diff_plot

#
# Remove intermediate data
#
remove_replicate_intermediate_data:
	source venv/bin/activate \
	&& cd replication-workflow \
		&& make remove_intermediate

remove_reuse_intermediate_data:
	source venv/bin/activate \
		&& cd reusage-workflow \
		&& make remove_intermediate

#
# Publish replication ERC on Invenio RDM
#
publish_replication: remove_replicate_intermediate_data
	source venv/bin/activate \
		&& cd publication-workflow \
		&& make ingest compendium=experiment-rep-cbersdatacube token=$$token url=$$url path=replication-workflow
	
#
# Publish reusage ERC on Invenio RDM
#
publish_reusage: remove_reuse_intermediate_data
	source venv/bin/activate \
		&& cd publication-workflow \
		&& make ingest compendium=experiment-rep-cbersdatacube token=$$token url=$$url path=reusage-workflow
