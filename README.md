# metaRUpore

metaRUpore codifies the analytical procedures involved in our 
2-stage adaptive sequencing based community normalization (short as **adaptive normalization**) workflow. The workflow is aimed to normalize the genome coverage of different populations within a community by unblocking reads of the dominant populations during adaptive nanopore sequencing. The metagenome (fasta format) generated in the first stage regular sequencing (~1hour) will be used as input to determine the target to unblock duing the 2nd-stage adaptive sequencing (48hour).  

metaRUpore will generated **a reference.fasta, a target list as well as a toml file** required to implement 2nd-stage adaptive sequencing with ReadFish(https://github.com/LooseLab/readfish). 

Please read below instructions carefully to avoid unnecessary errors.

## Installation 
### Pre-requisites for ARGpore 
	
	GNU parallel	### sudo apt install parallel
	git lfs	        ### sudo apt install git-lfs
	fgrep
	R and library: plyr, data.table, doParallel, foreach 
	

### Setup metaRUpore
	
	git clone https://github.com/sustc-xylab/metaRUpore.git
	
	cd metaRUpore
	
	bash ./setup.sh	

The setup.sh will install **Centrifuge** and then download **bacteria+archaea+virus database for Centrifuge, MetaPhlan2 Markergene** for you. It will take at least **1 hour** to finish, please stay patient :)


## Using MetaRUpore 
Once installed metaRUpore, all needed analysis is wrapped up in one executable named **metaRUpore.sh**. Please **use bash instead of sh** to initiate metaRUpore.sh

First of all, the user should fill in the taxa names they intended to manually set to accept during adaptive sequencing into the **keep.csv** ,this keep.csv should be kept in the same directory of your input.fasat

*Since metaRUpore will read keep.csv by column, therefore you don't need to keep the hiearchy phylogeny structure of your inputed taxon. Instead simply input the taxon names you don't want to eject in the correct taxonomic level.*

This is how keep.csv looks like:

|kingdom  |phylum|class|order|family|genus|species| 
| --------| ---- |
| Archaea |   your input   |
| Virus  |   your input   |


**NOTICE:**
	To avoid cross-writing of intermediate files, **each metaRUpore run should have an independent working directory**. To improve annotation accuracy, metaRUpore only analyze the **> 1kbp** portion of your input.fasta.

Recommended usage of metaRUpore is:
	
	mkdir -p demo
	cp keep.csv demo
	cp test.fa demo 
	cd demo 
	bash $PATH_to_metaRUpore/metaRUpore.sh -f test.fa -t 20 > metaRUpore.log


	
#### Output files 
All output files of metaRUpore are stored in the working directory.

Main output files include:
	
	reference.fa    a fasta file containing reads that could be used as reference for the ReadFish adaptive sequencing run
    target.txt      a list of reads name that wll be used as target for ReadFish adaptive sequencing (reads hit to target will be reject during adaptive sequencing)
    metaRU.toml     toml file containing the configuration of ReadFish adaptive sequencing run

	
The taxonomy annotation algorithm of metaRUpore is the sampe with our ARGpore2 tool (https://github.com/sustc-xylab/ARGpore2), in which taxonomic annotation is derived by combining results of a modified version of Centrifuge and MetaPhlan2 markergene database.

## *Citation:*

If you use metaRUpore in your metagenome analysis please cite:

Xia, Y., Li, A.-D., Deng, Y., Jiang, X.-T., Li, L.-G., and Zhang, T. (**2017**) MinION Nanopore Sequencing Enables Correlation between Resistome Phenotype and Genotype of Coliform Bacteria in Municipal Sewage. *Front Microbiol* 8: 2105.

##### Tools included in metaRUpore should be also cited, these tools includes: 

last, Centrifuge, MetaPhlan2, GNU parallel, R, python


