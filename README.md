
NAME is an open source pipelines for Mass Spectrometry Data Pre-Processing and Quantification, wrapped in a Docker container. Identification is performed by utilizing [MSGF+ tool developed by PNNL](https://omics.pnl.gov/software/ms-gf), and Quantification is conducted by utilizing MSnbase, bioconductor pacakge by Laurent Gatto et. all.

NAME uses Bioconductor proteomics image as the base image.

### Requirements
To run NMAE Docker engine must be installed. [Click here](https://docs.docker.com/engine/installation/) for a detailed information to install Docker engine on various operating system including Windows and MacOS.

Protein identification and quantification is a computationally intensive process. Depending on the size of the data, at least 4Gb available memory on the Docker Machine is required. Click here for more information on increasing the memory allocation for Docker engine on VirtualBox machine for MacOS and Windows Users.

![Adjusting RAM allocation for Docker Machine](media/ram.png =250x)

### Input 
The container takes Mass Spectrometry  (MS2) data ("\*.mzml","\*.mgf", "\*.mzxml", "\*.ms2", "\*.pkl") and peptide sequences files (\*.fasta). It is advised to put only the files to be computed in the folder as a separate sessions (e.g. different project for each folder).

Alternatively, if the files are accessible on FTP server, a CSV file with the information about the files can as the input. The container reads the information, download the files and run the computation.

In either case, the folder must be mounted to the container's "/root/data" (using ```-v``` tag). [Click here](http://container-solutions.com/understanding-volumes-docker/) for more information about Docker Volumes. 

### Output
For each MS2 file provided, a MZID file containing the protein identification is generated. When the pipelines completed, a file ```LabelledQuant.csv``` or ```LabelFreeQuant.csv```, and ```SpectrumCount.csv``` are also generated. LabelledQuant.csv``` or ```LabelFreeQuant.csv``` is the quantified result for either Labelled or LabelFree respectively. ```SpectrumCount.csv``` contains more detailed information including Spectrum No, Pep Sequence, and e-value that may be useful for filtering and further analysis. 

### Running the container
Make sure to put the files to compute on a separate folder under the system Users files.
On Windows, usually starts with /c/Users/YOURWINDOWSUSERNAME
On MacOs, usually starts with /Users/YOURMACUSERNAME
ON Linux, there is no restriction.

To run the container (LabelFree):

```
docker pull kristiyanto/msgf:labelfree
docker run --rm -v /c/Users/path/to/your/file:/root/data kristiyanto/msgf:labelfree
```

To run the container (Labelled):

```
docker pull kristiyanto/msgf:itraq
docker run --rm -v /c/Users/path/to/your/file:/root/data kristiyanto/msgf:itraq
```

### Contact Information

You are invited to contribute for new features, updates, fixes by sending pull requests.
