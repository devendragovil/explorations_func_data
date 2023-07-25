#birds circular fourier basis
rm(list = ls())

library(fdapace)
library(tidyverse)
library(plyr)
library(pracma)
library(tidyr)
library(kdensity)
library(circular)
library(fda)
library(ggradar)

inat <- read.csv("~/Desktop/repos/explorations_func_data/notebooks/iNat_bird_counts_weekly.csv")
ebird <- read.csv("~/Desktop/repos/explorations_func_data/notebooks/ebird_data_135_weekly_nn.csv")

#subset ebird data
ebird = ebird[,-(5:6)]
head(ebird)


#reshape iNat data
head(inat)
colnames(inat) = c("X","AVIBASEID", 1:52)

inat_long = inat %>% pivot_longer(cols = as.character(1:52),
                                  names_to="WEEK",
                                  values_to="OBSERVATION.COUNT")
inat_long$WEEK = as.numeric(inat_long$WEEK)


##check total obs counts

for(i in 1:length(ebird_df_list)){
  print(c(i,sum(ebird_df_list[[i]]$OBSERVATION.COUNT), ebird_df_list[[i]]$AVIBASEID[1]))
}

####remove 10, 13, and 49: obs counts too small
#"0B1B2EB6"
#"115F04DD"
#"56036504"

out = c("0B1B2EB6","115F04DD","56036504")
`%notin%` = Negate(`%in%`)


ebird_132 = ebird %>% filter(AVIBASEID %notin% out)
inat_132 = inat_long %>% filter(AVIBASEID %notin% out)





#split df by avibaseid, save into a list of dfs
ebird_df_list = dlply(.data = ebird_132, 
                      .variables = 'AVIBASEID',
                      .fun = function(x){return(x)})


inat_df_list = dlply(.data = inat_132, 
                      .variables = 'AVIBASEID',
                      .fun = function(x){return(x)})


#make every dataset have weeks 1-52 & return angle for circular plot
std_wks = function(df){
  
  temp_id = df$AVIBASEID[1]
  
  blank_weeks = data.frame(AVIBASEID = temp_id, WEEK = 1:52, OBSERVATION.COUNT = 0)
  
  joined_unsorted = join(df, blank_weeks, by = "WEEK", type = "full")
  
  joined_sorted = arrange(joined_unsorted, WEEK)
  
  joined_sorted$angle = joined_sorted$WEEK*(2*pi/52)
  
  return(joined_sorted)
  
}


#demo on first bird df
demo = ebird_df_list[[1]]
demo
demo = std_wks(demo)
demo


#apply to all dfs in list
ebird_df_list = dlply(.data = ebird_132, 
                         .variables = 'AVIBASEID',
                         .fun = std_wks)

inat_df_list = dlply(.data = inat_132, 
                      .variables = 'AVIBASEID',
                      .fun = std_wks)


smooth_fourier_k = function(df, k){
  
  t = df$angle
  y = df$OBSERVATION.COUNT
  df$frac_y = df$OBSERVATION.COUNT/sum(df$OBSERVATION.COUNT)
  
  k_basis = create.fourier.basis(rangeval = range(t), nbasis = k)
  smooth_y_basis = smooth.basis(argvals = t, y = y, fdParobj = k_basis)$fd
  
  eval_y = eval.fd(t, smooth_y_basis)
  eval_y = pmax(eval_y, 0.001) #prevent negatives
  df$smooth_count = eval_y
  df$dens = eval_y/trapz(t, eval_y)
  
  return(df)
}


####visual inspection
# demo = ebird_df_list[[26]]
# 
# test = demo %>% smooth_fourier_k(k = 8)
# test
# 
# ggplot(test) + 
#   geom_point(aes(x = angle, y = OBSERVATION.COUNT)) + 
#   geom_line(aes(x = angle, y = smooth_count))
# 
# ggplot(test) + 
#   geom_line(aes(x = angle, y = dens))

ebird_df_list_smooth = lapply(X = ebird_df_list, FUN = smooth_fourier_k, k=8)
ebird_long_smooth = bind_rows(ebird_df_list_smooth)

eplot = ggplot(ebird_long_smooth) +
  geom_path(aes(angle, dens, group = AVIBASEID), alpha = 0.25) + 
  ggtitle("ebird")
eplot

eplot_circ = ggplot(ebird_long_smooth) +
  geom_path(aes(angle, dens, group = AVIBASEID), alpha = 0.25) + 
  scale_x_continuous(breaks=seq(0,3*pi/2, pi/2)) + 
  coord_polar(theta = "x", start = 3*pi/2, direction = 1) +
  ggtitle("ebird")
eplot_circ


inat_df_list_smooth = lapply(X = inat_df_list, FUN = smooth_fourier_k, k=8)
inat_long_smooth = bind_rows(inat_df_list_smooth)

iplot = ggplot(inat_long_smooth) +
  geom_path(aes(angle, dens, group = AVIBASEID), alpha = 0.25) + 
  ggtitle("inat")
iplot

iplot_circ = ggplot(inat_long_smooth) +
  geom_path(aes(angle, dens, group = AVIBASEID), alpha = 0.25) + 
  scale_x_continuous(breaks=seq(0,3*pi/2, pi/2)) + 
  coord_polar(theta = "x", start = 3*pi/2, direction = 1) +
  ggtitle("inat")
iplot_circ


write.csv(inat_long_smooth, file = "inat_dens_df.csv")
write.csv(ebird_long_smooth, file = "ebird_dens_df.csv")
