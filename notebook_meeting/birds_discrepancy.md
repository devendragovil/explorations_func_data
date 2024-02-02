# Birds with highest discrepancy in observation patterns across years

## Methodology
Jensen Distance for smoothed curves is chosen as the distance metric to quantify "distance" between two different observation curves. 4 such distances were computed for each bird:
- iNat-19 vs iNat-22 (Column Name - iNat)
- eBird-19 vs eBird-22 (Column Name - eBird)
- iNat-19 vs eBird-19 (Column Name - Y19)
- iNat-22 vs eBird-22 (Column Name - Y22)

Since there is an implicit assumption of yearly seasonality in our assumption, birds where there is little distance between datasets (Y19 and Y22 colums as defined above) but where there is appreciable distance across years (iNat and eBird columns as defined above) are extremely concerning.

To quantitatively filter for such cases, two metrics were devised (using columns as defined earlier):
1. Highest Discrepancy Difference which is: 
    $$\frac{iNat + eBird}{2} - \frac{Y19 + Y22}{2} $$
2. Highest Discrepancy Ratio which is: 
    $$\frac{iNat + eBird}{Y19 + Y22}$$

The words 'difference' and 'ratio' below would be used to describe these above mentioned measures.

To select anamolous birds, the thresholds for both difference and ratio must be met. The following examples help us understand the reason:

### Example 1
Bird 68EA281A has a difference of 0.038106 and a ratio of 1.817987. While the ratio is large, that is because of a small denominator in computation as seen from the graph below:

![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_68EA281A.png)

### Example 2
Bird 135564AA has a difference of 0.113568 and a ratio of 1.374282. While the difference is large, that is because the curves are further apart from each other across both years and datasets.

![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_135564AA.png)

Hence, based on this, and after some tinkering with thresholds, birds with a ratio > 1.5 and difference > 0.08 were selected.

## Anamolous Birds



Based on above the anamolous birds are:
<table border="1" class="dataframe">  <thead>    <tr style="text-align: right;">      <th></th>      <th>AvibaseID</th>      <th>iNat</th>      <th>eBird</th>      <th>Y19</th>      <th>Y22</th>      <th>Discrepancy diff</th>      <th>Discrepancy ratio</th>    </tr>  </thead>  <tbody>    <tr>      <th>0</th>      <td>2DABF98F</td>      <td>0.459</td>      <td>0.447</td>      <td>0.124</td>      <td>0.154</td>      <td>0.314</td>      <td>3.267</td>    </tr>    <tr>      <th>1</th>      <td>AF0C7BDE</td>      <td>0.563</td>      <td>0.393</td>      <td>0.238</td>      <td>0.065</td>      <td>0.327</td>      <td>3.154</td>    </tr>    <tr>      <th>2</th>      <td>BCBD2EAE</td>      <td>0.551</td>      <td>0.494</td>      <td>0.201</td>      <td>0.167</td>      <td>0.339</td>      <td>2.838</td>    </tr>    <tr>      <th>3</th>      <td>4AAEF549</td>      <td>0.554</td>      <td>0.489</td>      <td>0.174</td>      <td>0.197</td>      <td>0.336</td>      <td>2.811</td>    </tr>    <tr>      <th>4</th>      <td>C5971E25</td>      <td>0.559</td>      <td>0.507</td>      <td>0.174</td>      <td>0.212</td>      <td>0.34</td>      <td>2.758</td>    </tr>    <tr>      <th>5</th>      <td>B48335B1</td>      <td>0.419</td>      <td>0.318</td>      <td>0.152</td>      <td>0.131</td>      <td>0.226</td>      <td>2.597</td>    </tr>    <tr>      <th>6</th>      <td>E1714A09</td>      <td>0.695</td>      <td>0.563</td>      <td>0.335</td>      <td>0.221</td>      <td>0.35</td>      <td>2.26</td>    </tr>    <tr>      <th>7</th>      <td>1456993D</td>      <td>0.42</td>      <td>0.337</td>      <td>0.223</td>      <td>0.135</td>      <td>0.199</td>      <td>2.109</td>    </tr>    <tr>      <th>8</th>      <td>4E192262</td>      <td>0.72</td>      <td>0.4</td>      <td>0.35</td>      <td>0.19</td>      <td>0.29</td>      <td>2.075</td>    </tr>    <tr>      <th>9</th>      <td>BB6B236F</td>      <td>0.216</td>      <td>0.231</td>      <td>0.134</td>      <td>0.086</td>      <td>0.114</td>      <td>2.038</td>    </tr>    <tr>      <th>10</th>      <td>0716A71C</td>      <td>0.329</td>      <td>0.221</td>      <td>0.171</td>      <td>0.104</td>      <td>0.137</td>      <td>1.999</td>    </tr>    <tr>      <th>11</th>      <td>F6DF700B</td>      <td>0.512</td>      <td>0.386</td>      <td>0.256</td>      <td>0.202</td>      <td>0.22</td>      <td>1.96</td>    </tr>    <tr>      <th>12</th>      <td>28A4DA76</td>      <td>0.364</td>      <td>0.186</td>      <td>0.168</td>      <td>0.117</td>      <td>0.133</td>      <td>1.931</td>    </tr>    <tr>      <th>13</th>      <td>90B13ACF</td>      <td>0.438</td>      <td>0.17</td>      <td>0.237</td>      <td>0.126</td>      <td>0.123</td>      <td>1.678</td>    </tr>  </tbody></table>

The graphs for each of the birds is present below:

![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_0_2DABF98F.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_1_AF0C7BDE.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_2_BCBD2EAE.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_3_4AAEF549.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_4_C5971E25.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_5_B48335B1.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_6_E1714A09.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_7_1456993D.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_8_4E192262.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_9_BB6B236F.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_10_0716A71C.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_11_F6DF700B.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_12_28A4DA76.png)
![](/Users/devendragovil/AllClassesMaterial/RA_Func/explorations_func_data/notebook_meeting/birds_graphs/output_13_90B13ACF.png)


