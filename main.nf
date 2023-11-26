//nextflow.enable.dsl = 2

/*
 Let's try first running Baysor with the Apptainer image.
 For this, a job that prints the Baysor help and saves it 
 to a text file will be used as a workflow.
*/

params.spots = "${projectDir}/spots.csv"
//params.x = 'xc'
//params.y = 'yc'
//params.gene_column = 'target'
//params.min_molecules = 5
//params.scale = 24
//params.scale_std = 0.2//'25%'
//params.n_clusters = 15
//params.prior_seg_confidence = 0.2
//docker_img = "docker://segonzal/baysor"

process SEGMENT {
    debug true

    //container docker_img
    cpus 4
	memory '8 GB'
	executor 'slurm'
    
    input:
    path spots

    output:
    stdout
    //path '*.txt'

    script:
    def args = task.ext.args ?: ''
    """
    /app/bin/baysor run $spots $args
    """
}

workflow {
    test_channel = SEGMENT(params.spots)
    test_channel.view()
}
