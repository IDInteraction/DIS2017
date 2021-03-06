# How should we train a tool to recognise behaviour from video?
## David Mawdsley, Aitor Apaolaza, Robert Haines, Caroline Jay


### Requirements

We built the paper on a Unbunu Linux 16.04 system.  The following packages, which  are unlikely to be installed by default, were used:

* A functioning LaTeX system, with the `texlive-fonts-extra` package installed
* R, including tidyverse. Tidyverse requires the following packages, that may not be installed by default:
  + libcurl4-openssl-dev
  + libssl
  + libxml2-dev
* Python 2.7. The following packages are also required:
  + sklearn (pip install sklearn (0.18.1))
  + NumPy (1.11.0)
  + SciPy (0.18.1)
  + Pandas (0.17.1)
  + OpenCV (2.4.9.1) (If installing OpenCV with pip the package is `opencv-python`)
* Docker (only used if rebuilding the tracking files)

### Source code

Clone repository & submodules from github:
```shell
$ git clone https://github.com/IDInteraction/DIS2017.git
$ cd DIS2017
$ git submodule init
$ git submodule update
```

If you are not using public key authentication for GitHub you may need to edit
.gitmodules and change the url of the submodules to
`https://github.com/IDInteraction/abc-display-tool.git` and `https://github.com/IDInteraction/spot_the_difference.git`  before running:
```shell
$ git submodule sync
$ git submodule init
$ git submodule update
```

### Data preparation

Copy the attention data from `Attention/` and the tracking data from `Tracking/`. Copy transition annotations from spot_the_difference submodule to `Attention/`:
```shell
$ cp spot_the_difference/controlfiles/transitionAnnotations.csv ./Attention/
```
----------------

### (Optional) Generating tracking from source videos 

To generate tracking from the source videos, copy all the videos to `video/`, and the `Attention` folder to `Attention/`. Install the IDInteraction tracking-tools to give access to the required scripts and Docker images.

If using the original bounding boxes copy `InitialBoundingBoxes/` from Dropbox to the `InitialBoundingBoxes/` directory. (If specifying new bounding boxes edit the `./generateTracking.sh` script where indicated).

Run `./generateTracking.sh`. This will run `CppMT` on each part of the video, Openface on the whole video, and copy/compress these in the appropriate places. If new bounding boxes are required these will be prompted for at the start of the process. The tracking/openface code is run *after* we have a bounding box for each participant and experiment part; this will take many hours to run.


----------------------

To encode attentions, run `./encodeAttentions.sh`

### Build the paper

Finally, load the `DIS2017` project into R Studio, open `IDInteraction_DIS.Rnw` and hit "compile PDF". Wait a while; this takes around 30 mins to run the classifier for all combinations specified in the paper. `Runlog.txt` will log progress.  Output from Knitr is cached, so successive runs should take much less time.  If the classifier fails for any reason you should remove the `cache` folder before recompiling the document.
