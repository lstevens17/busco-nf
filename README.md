# busco-nf

Launch a interactive session with minimal resources: 

```
mbMem=5000; bsub -n 1 -q long -R"span[hosts=1] select[mem>${mbMem}] rusage[mem=${mbMem}]" -M${mbMem} -Is bash
```

Run the nextflow pipeline:

```
nextflow run busco.nf -profile farm -c busco.config --genomes_dir [absolute/path/to/genomes/directory]
```

busco_env.yml will allow you to create a working busco conda environment
