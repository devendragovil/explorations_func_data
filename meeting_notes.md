# Meeting Notes

## Date: May 7, 2023

1. Control for effect of human activity on monthly basis


## Date: May 2, 2023
1. quality_grade --> research verified by other users

### To Do:
1. Filter for bounding box, research grade quality, minimum no. of observations (try different thresholds), use smoothing for estimating curves  (Done)
    - Start one year, get started with that, not averaging right now, keep separate
    - Possible ideas? --> Change after Covid- Analysis
2. Match to physiological data, (Done)
3. func regression against curves, (optional, try best) (Pending)
4. Keep track of DL/LLM paper for possible exploration of these upcoming methods


## Date: April 25, 2023
### Meeting Notes
1. Normalize birds obs with total obs of that bird (fractional counts need to be compared with weeks)
2. Commented birds in prior art not working
3. Smooth curves, kernel smoothing reduces bias
4. Filter out rare birds, try to use more exhaustive list of birds

### To Do:
1. Run for all birds (Done)
2. Refactor the code, push to repo (Done)
3. Get EDA for relative frequencies (Done)
4. Look for other data (Done)



## Date: April 21, 2023
1. Compare ebirds with iNaturalist, use bird frequency, ebirds is for professionals and might be better in quality. Construct density curves for both and compare, ebirds is ground truth. 
2. Collaborator in UC Davis, Laci Gerhardt, 
3. Do with all years, until data is available.
4. Find data on birds itself, wingspan, morphological predictors, random object regression, response is density curves, predictors are measurement vectors
5. Several bounding boxes, see seasonality curves change, (holding year constant), seasonality curves change viz Lat/Long, Years etc. --> Climate change implications? Phenology 

### To Do:
- By: Tuesday, April 25, 2023
1. Create Github repository (Done)
2. Make API work (Done)
3. Replicate EDA (Done)
4. Explore and perform own EDA (Done)