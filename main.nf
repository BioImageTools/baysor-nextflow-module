//nextflow.enable.dsl = 2

/*
 Let's try first running Baysor with the Apptainer image.
 For this, a job that prints the Baysor help and saves it 
 to a text file will be used as a workflow.
*/

params.input = 'help'
params.spots = "${projectDir}/transcripts/*spots.csv"
//params.spots = "/Users/segonzal/Documents/Repositories/iss_transcripts/*.csv"
//params.x = 'xc'
//params.y = 'yc'
//params.gene_column = 'target'
//params.min_molecules = 5
//params.scale = 24
//params.scale_std = 0.2//'25%'
//params.n_clusters = 15
//params.prior_seg_confidence = 0.2
//docker_img = "sebgoti/baysor_image:latest"
docker_img = "segonzal/baysor_installation_inside_ubuntu:latest"

process SEGMENT {
    debug true
    container docker_img
    
    input:
    path spots

    output:
    stdout
    //path '*.txt'

    script:
    def args = task.ext.args ?: '' // if task.ext.args is empty then pass an empty string
    """
    /app/bin/baysor run $spots $args -p
    """
}
//     /app/bin/baysor run $spots -x ${params.x} -y ${params.y} -g ${params.gene_column} -m ${params.min_molecules} -s ${params.scale} --scale-std ${params.scale_std} --save-polygons GeoJSON -p

// ${spots} -x xc -y -yc -g target -m 4 -s 24 -o . 

workflow {
    //scale_stds_ch = Channel.fromList(['20%', '30%', '40%'])
    //seg_confidence_ch = Channel.fromList([0.1, 0.2, 0.3])
    //spots_channel = Channel.fromPath(params.spots)

    test_channel = SEGMENT(Channel.fromPath(params.spots))
    test_channel.view()
}
