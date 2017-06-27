# writer-identification-hist-sparse
This repository contains code for my paper titled "Online Writer Identification using Sparse Coding and Histogram based descriptors" published as an oral in the 15th International Conference on Frontiers in Handwriting Recognition (ICFHR-2016).
Download a copy of the paper [here](https://drive.google.com/file/d/0BxhUwxvLPO7TOXY3MXpiUmc2Xzg/view). The paper is also available on IEEE Xplore [here](http://ieeexplore.ieee.org/abstract/document/7814126/).

If you use this work, please cite the paper:

    @inproceedings{dwivedi2016online,
      title={Online Writer Identification Using Sparse Coding and Histogram Based Descriptors},
      author={Dwivedi, Isht and Gupta, Swapnil and Venugopal, Vivek and Sundaram, Suresh},
      booktitle={Frontiers in Handwriting Recognition (ICFHR), 2016 15th International Conference on},
      pages={572--577},
      year={2016},
      organization={IEEE}
    }

[The IAM On-Line Handwriting Database](http://www.fki.inf.unibe.ch/databases/iam-on-line-handwriting-database) is used in this work. 

### Instructions and comments for using this repository

1. The first writer of the dataset is not used because of poor quality of data. The 5th writers has 7 documents only. To make them 8, 8th document is a copy of 7th document. The rest of the data-set is used as is it.

2. Modify the root directory in `DataRead.m` to point to the dataset directory.

3. `Master_textline.m` and `Master_para.m` are the 2 main scripts which are to be executed to get results. `Master_para.m` is for paragraph level writer identification, and `Master_textline.m` is for text-line level writer identification (as dicussed in the paper). All other .m files are supporting functions. Brief descriptions of relevant supporting files is given below:
    * `KNN.m` is a function implementing K nearest neighbour classifier for paragraph level code. `svm4_top.m` gives the top1, top3, top5 accuracy for paragraph level code. 
`svm4line.m` gives the top1, top3, top4 ... , top20 accuracy for text-line level code. You can choose to use rbf / linear kernel by modifying this function. `findWriter.m` is used by the function `svm4line`.
    * `DataRead.m` uses the function `DocRead.m`, `xml2struct.m` and `strokesGen_sampling.m` / `strokesGen_Nosampling.m`(depending on whether you want to sample the sub-strokes to 32 points). Sampling to 32 points gives better results. 
    * `Dlearn_tf_idf.m` uses the sparse toolbox to calculate the sparse dictionary and the tf, idf vectors.
    * `feat_HOGS.m` is used to calculate the histogram based features. `feat2.m` can be used to calculate spectral features for comparison.

4. `start_spams.m` and the folder "build" are files used by the sparse toolbox. Please compile the toolbox using gcc on your pc and place the folder named "build" generated after compilation in the same directory as other .m files. (Link to toolbox: http://spams-devel.gforge.inria.fr/). If you use this toolbox, please consider citing them, references are given on the link provided.

