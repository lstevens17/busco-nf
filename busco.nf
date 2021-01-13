nextflow.enable.dsl=2

date = new Date().format( 'yyyyMMdd' )
params.outdir = "busco-${date}"

input_genomes = Channel.fromPath("${params.genomes_dir}/*fa", checkIfExists: true).map{ file -> tuple(file.simpleName, file) }

process run_busco {
	conda "$HOME/miniconda3/envs/busco_env/"
	publishDir "${params.outdir}", mode: 'copy'
	errorStrategy 'ignore'
	queue 'long'	

	input:
		tuple val(species), path(genome)

	output:
		path "${species}"

	script:
	"""
		busco -i $genome -l /lustre/scratch116/tol/teams/team301/dbs/busco_2020_08/busco_downloads/lineages/lepidoptera_odb10 -o $species -m genome -c ${task.cpus} --offline
	"""
}

workflow {
	run_busco(input_genomes)
}
