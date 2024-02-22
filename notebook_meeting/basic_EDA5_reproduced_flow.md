# Flow of data points

1. We get our dataset from the eBird portal and GBIF portal (for research grade iNat observations). The requested dataset was achieved after specifying some filters, which were:
   1. iNat : Country is limited to only USA and year to that specific year
   2. eBird : Country is limited to USA, State to CA, and year to that specific year.
2. Number of rows in the dataset
   1. iNat 19 - 3.32 million
   2. iNat 22 - 6.68 million
   3. eBird 19 - 8.69 mn
   4. eBird 22 - 12.67 mn
   5. iNat 19 (unq species) - 49,685
   6. iNat 22 (unq species) - 58,267
   7. eBird 19 (unq species) - 1,088
   8. eBird 22 (unq species) - 1,108
3. We now apply the LAT and LONG filters, as well as State filter for iNat, to limit data to only CA observations in the specific bounding box:
   1. iNat 19 - 363,386
   2. iNat 22 - 658,345
   3. eBird 19 - 5,168,169
   4. eBird 22 - 7,018,777
   5. iNat 19 (unq species) - 10,757
   6. iNat 22 (unq species) - 12,273
   7. eBird 19 (unq species) - 918
   8. eBird 22 (unq species) - 953
4. Then we merge iNat with the dictionary of available eBird-avibase mappings, this yields 392 birds available for both iNat 19 and iNat 22.
5. Now we see common birds for both iNat (for which AvibaseID is available from step 4 above) and eBird dataset, common birds:
   1. 353 for the year 2019 
   2. 341 for the year 2022
6. Taking commong birds among all 4 datasets at this point: 331 birds
7. Removing birds with zero observation counts of > 46:
   1. Final list of birds 260