#
# replicate the CBERS Data Cube article metholody
#
replicate:
	cd replication-workflow \
		&& make workflow

#
# reuse the ERC created from CBERS Data Cube replication
#
reuse:
	cd reusage-workflow \
		&& make workflow
