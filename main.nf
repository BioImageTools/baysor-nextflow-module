//nextflow.enable.dsl = 2

/*
 Let's try first running Baysor with the Apptainer image.
 For this, a job that prints the Baysor help and saves it 
 to a text file will be used as a workflow.
*/

params.spots = "${projectDir}/spots.csv"
params.mask = "${projectDir}/mask_boundaries.tif"

//docker_img = "docker://segonzal/baysor_installation_inside_ubuntu:latest"
docker_img = "segonzal/baysor_installation_inside_ubuntu:latest"


process SEGMENT {
    debug true

    container docker_img
    cpus 4
	memory '8 GB'
	// executor 'slurm'
    
    input:
//    tuple path(spots), path(mask)
    path spots
    path mask

    output:
    stdout
    //path '*.txt'

    script:
    def args = task.ext.args ?: ''
    """
    /app/bin/baysor run $spots $mask $args
    """
}

workflow {
    test_channel = SEGMENT(params.spots, params.mask)
    test_channel.view()
}
