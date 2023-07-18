#birds circular smoothing
rm(list = ls())

library(fdapace)
library(tidyverse)
library(plyr)
library(pracma)
library(tidyr)

inat <- read.csv("~/Desktop/repos/explorations_func_data/notebooks/iNat_bird_counts_weekly.csv")
ebird <- read.csv("~/Desktop/repos/explorations_func_data/notebooks/ebird_data_135_weekly_nn.csv")





ebird = ebird[,-(5:6)]
head(ebird)



#split df by avibaseid, save into a list of dfs
ebird_df_list = dlply(.data = ebird, 
      .variables = 'AVIBASEID',
      .fun = function(x){return(x)})



demo = ebird_df_list[[1]]

x = demo$OBSERVATION.COUNT


#make function pad_df which:
#for each df, copy the last 10 weeks of year to beginning and first 10 weeks of year to end. 
pad_df = function(df){
  df_begin = head(df, 10)
  df_begin$WEEK = df_begin$WEEK + 52 #fix week index
  
  
  df_tail = tail(df, 10)
  df_tail$WEEK = df_tail$WEEK - 52 #fix week index
  
  padded_df = rbind(df_tail, df, df_begin)
  return(padded_df)
}

#demo on first bird df
demo = ebird_df_list[[1]]
pad_df(demo)

#apply to all dfs in list
ebird_paddf_list = dlply(.data = ebird, 
                      .variables = 'AVIBASEID',
                      .fun = pad_df)

#function which creates densities on year from padded df 
dens_yr = function(df_padded){
  
  df_padded$smoothed_counts = Lwls1D(bw = 6, kernel_type = "gauss", 
                                     xin = df_padded$WEEK, yin = df_padded$OBSERVATION.COUNT, 
                                     xout = df_padded$WEEK)
  df_yr = df_padded %>% subset(WEEK>0 & WEEK<=52)
  
  df_yr$dens = df_yr$smoothed_counts/trapz(df_yr$WEEK, df_yr$smoothed_counts)
  
  return(df_yr)
}

df_padded = ebird_paddf_list[[1]]

dens_yr(df_padded)

#apply to all dfs in list
ebird_dens_list = lapply(ebird_paddf_list, FUN = dens_yr)

ebird_dens_list

ebird_dens_df = bind_rows(ebird_dens_list)

#entire processing function:
process_dens = function(df){
  paddf_list = dlply(.data = df, 
                    .variables = 'AVIBASEID',
                    .fun = pad_df)
  
  dens_list = lapply(paddf_list, FUN = dens_yr)
  
  dens_df = bind_rows(dens_list)
  
  return(dens_df)
}


#reshape iNat data
head(inat)
colnames(inat) = c("X","AVIBASEID", 1:52)

inat_long = inat %>% pivot_longer(cols = as.character(1:52),
                      names_to="WEEK",
                      values_to= "OBSERVATION.COUNT")
inat_long$WEEK = as.numeric(inat_long$WEEK)

#process inat data

inat_dens_df = process_dens(inat_long)


write.csv(inat_dens_df, file = "inat_dens_df.csv")
write.csv(ebird_dens_df, file = "ebird_dens_df.csv")
