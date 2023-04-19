# ChIP-Seq-Analysis-101 #


The current repository implements a ChIP-Seq analysis pipeline.

The analysis that implements is based / inspired on the UCLA QCBio 2020 workshop but is not an one by one implementation, since additional tools or different configurations may have been used.

Analysis / Assay

Test IFNa - STAT1 -  Antiviral / Inflammatory response 

The publication ["Regulation of type I interferon responses"](https://doi.org/10.1038/nri3581)




## How to run the pipeline ##


The basic setup can be done using  commands and scripts that are available through makefile.
All the following are make commands and must be run from the base directory of the project (where  Makedile is created).


1. **make build-all-images** : That command will build all docker images in your local machine. It may take somne time depending if the docker can find the ubuntu base image on your machine or need to download it. Most of the  tools are based on the base images and will not download a lot of additional data. The average size of images is around 500 MB for most basic and simple tools and around 1 GB for tools that need java to be instaled.

2. **make create-pipeline-folder-structure** : This command will create the folder structure needed for the project. Will create a directory named  **data** at the root level of the project and a number of subdirectories used for downloading data and running the pipelines.





## References ##


1.  Ivashkiv, L., Donlin, L. Regulation of type I interferon responses. Nat Rev Immunol 14, 36–49 (2014). https://doi.org/10.1038/nri3581

