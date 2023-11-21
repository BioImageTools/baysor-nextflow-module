# baysor-nextflow-module
Nextflow module to use Baysor for cell segmentation in imaging-based spatial-transcriptomics.

## Installation
To run locally: Nextflow and Docker. Either create the image from the given Dockerfile or pull the image from the repo commented on `main.nf`. The workflow is currently working using Docker (also printing HTML files with summaries of the segmentation). For creating the Apptainer image one can take the Dockerfile and do the following:

`$ docker save -o baysor.tar <name-of-docker-image:tag`

and on the HPC build the Apptainer image:

`$ apptainer build baysor.sif docker-archive://baysor.tar`

Running on the HPC is working but there is currently an issue when saving the output HTML plots, so the `-p` flag must be silenced.
