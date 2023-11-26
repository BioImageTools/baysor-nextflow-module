params.spots = "${projectDir}/transcripts/*.csv"
params.masks = "${projectDir}/masks/*.tif"

//Channel.fromPath( [params.spots, params.masks] ).view()
//Channel.fromFilePairs( ['/Users/segonzal/Documents/Repositories/baysor-nextflow-module/transcripts/spots*{1,2}.fastq', '/other/data/QFF*_{1,2}.fastq'] )

csv_ch = Channel.fromPath(params.spots)
tif_ch = Channel.fromPath(params.masks)

csv_ch2 = csv_ch.map { it -> [[id:it.baseName], it]}
tif_ch2 = tif_ch.map { it -> [[id:it.baseName], it]}

//csv_ch2.view()
//tif_ch2.view()

new_ch = csv_ch2.join(tif_ch2)
new_ch.view()