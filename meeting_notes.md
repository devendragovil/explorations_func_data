# Meeting Notes


1. We can use GBIF, not yet though.
2. 

## Date: July 20th, 2023
1. eBird data only <= x OBS COUNT (x 10..)
2. Drop ebird OBS COUNT missing
3. Try species name as the UID
4. Look at outlier birds, investigate ( < 1 and > 1000 and ~ 1)


## Date: July 8, 2023

1. Summary statistics between iNat and ebird
2. Change at 52 week level
3. Circular smoothing function should have an option for kernel smoother

## Date: Jun 13, 2023

1. Missing Value Imputation for ebird and maximum obs count??
2. Observation Count validation, Realistic?
3. Quantize the distortion in iNat vs ebird for total viewings, 
    - compute without the normalization
    - investigate the ground truth data
    - descriptive analysis of curves, ebird vs iNat
4. Aggregate on the weekly level and then smooth (Kernel Smoothers)- Local weighted least squares - bandwidth -- choose visually
5. Smooth data before PCA and see if double peaks persist
6. Investigate using FPCA on the curves.
7. See lags across the datasets.
8. Add epsilon to resolve issues with various measures in probability measure. Figure out optimal transport map Dens 1 to dens 2: T(t) = (F1^{-1} \circ F2)(t).
9. PCA as a tool for exploratory data analysis, try alternate method that retain densities, Wasserstein PCA, Hilbert Space mapping
10. shift parameter that minimizes the average wasserstein distance across all curves. Objective function --> 1/n or distribution
    - Obj func: 1/n \sum_i W_2(f_{e,i}(t), f(inat,i)(t-c))
    - c_hat = minimizer
    - N obj functions, one per bird: L_i(c) = W_2(f_{e,i}(t), f(inat,i)(t-c)) —>
        N shift parameters: c_i which minimize L_i(c) and we could look at distribution

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