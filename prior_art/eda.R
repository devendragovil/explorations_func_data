rm(list = ls())
options(stringsAsFactors = F)
library(spocc)
library(magrittr)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(kdensity)


#weekly counts, make df
base = data.frame(species = "x", week = 1:52)

#source
db = 'gbif'


#i just looked at 2019 data at first
#daterange
daterange = c('2019-01-01', '2019-12-31')

#northern CA bounding box
boundbox = c(-124.409591,36.4701132878 ,-114.131211,	42.009518)

fallbirds = c("Bald Eagle",
              "Oak Titmouse",
              "Golden Eagle",
              "Varied thrush",
              "Ferruginous hawk",
              "Whimbrel",
              "Golden-crowned sparrow",
              "Red-tailed Hawk",
              "American Kestrel")

springbirds = c("Pintails",
                #"White-fronted Geese",
                #"Snow Geese",
                "Grebes",
                "White pelicans",
                "Great egret",
                "Snowy egret",
                "Great Blue heron",
                "Green heron",
                "American Bittern",
                "Peregrine Falcon",
                "Common loon",
                "Pacific loon",
                "Allen's Hummingbird")

otherbirds = c("Dark-eyed Junco",
               "California Towhee",
               "Cedar Waxwing",
               "California Scrub-Jay",
               "Cooper's Hawk",
               "Yellow-rumped Warbler",
               "Chestnut-backed Chickadee",
               "Red-shouldered Hawk",
               "Common nighthawk",
               #"Black swift",
               "Anna's Hummingbird",
               "American coot",
               "Sora",
               "American oystercatcher",
               #"Common Snipe",
               "Barn Owl",
               "Northern flicker",
               "American crow",
               "Common raven",
               "California Quail",
               "Oregon Junco",
               "Steller's Jay",
               "Rock Pigeon",
               "Killdeer",
               "Elegant tern",
               "Pelagic cormorant",
               "Hooded merganser",
               "Willet")


birds = c(fallbirds,springbirds,otherbirds)

df <- occ(query = "Oak Titmouse", from = "inat",
          date = daterange,
          geometry=boundbox,
          limit = 1000)

wks = data.frame(wkobs = df$inat$data[[1]]$observed_on_details.week)

test = wks %>% 
  group_by(wkobs) %>%
  summarise(y = length(wkobs))

data = base %>% left_join(test, by = c("week" = "wkobs")) %>%  mutate_all(~replace(., is.na(.), 0))





wklyobs = function(species, db){
  df <- occ(query = species, from = db,
            date = daterange,
            geometry=boundbox,
            limit = 1000)
  
  wks = data.frame(wkobs = df$inat$data[[1]]$observed_on_details.week)
  
  test = wks %>% 
    group_by(wkobs) %>%
    summarise(y = length(wkobs))
  
  data = base %>% left_join(test, by = c("week" = "wkobs")) %>%  mutate_all(~replace(., is.na(.), 0))
  
  data$species = paste(species)
  
  return(data)
}



df <- occ(query = "Oak Titmouse", from = "gbif",
          date = daterange,
          geometry=boundbox,
          limit = 1000)

wklyobs(species = "Oak Titmouse", db = "inat")


densobs = function(species, db){
  df <- occ(query = species, from = db,
            date = daterange,
            geometry=boundbox,
            limit = 1000)
  wks = data.frame(wkobs = df$inat$data[[1]]$observed_on_details.week)
  
  kde = kdensity(x = wks$wkobs, bw = 6,
                  kernel = "gaussian",
                  start = "uniform",
                  support = c(1,52))
  x = seq(1,52, length.out = 100)
  data = data.frame(species = species, 
                    x = x, 
                    dens = kde(x))
  
  return(data)
}

densobs("California Scrub-Jay", "inat")
densobs("Bald Eagle", "inat")

birds[1]


data_list = list()

for(b in seq(birds)){
  data_list[[b]] = densobs(birds[b], db="inat")
}

data = bind_rows(data_list)

write.csv(data, file = "birds.csv")


head(data)

densobs("California Scrub-Jay", "inat")





inat_data_list = list()

for(i in seq(fallbirds)){
  f = fallbirds[i]
  inat_data_list[[i]] = wklyobs(f, db="inat")
}

inatfalldata = bind_rows(inat_data_list)

ggplot(inatfalldata, aes(x = week, y = y)) + 
  facet_wrap(~species, scales = "free_y") + 
  geom_point() + 
  xlab("week") + ylab("obs. count")  +
  ggtitle("Autumnal birds: iNaturalist 2019")+ theme_bw(16)




springbirds = c("Pintails",
                #"White-fronted Geese",
                #"Snow Geese",
                "Grebes",
                "White pelicans",
                "Egrets",
                "Herons",
                "Bitterns",
                "Peregrine Falcon",
                "Loons",
                "Allen's Hummingbird")


inat_data_list = list()

for(i in seq(springbirds)){
  s = springbirds[i]
  inat_data_list[[i]] = wklyobs(s, db="inat")
}

inatspringdata = bind_rows(inat_data_list)

ggplot(inatspringdata, aes(x = week, y =  y)) + 
  facet_wrap(~species, scales = "free_y") + 
  geom_point() + stat_smooth(se = FALSE) +
  xlab("week") + ylab("obs. count")  +
  ggtitle("Vernal birds: iNaturalist 2019")+ theme_bw(16)




otherbirds = c("Dark-eyed Junco",
               "California Towhee",
               "Cedar Waxwing",
               "California Scrub-Jay",
               "Yellow-rumped Warbler",
               "Red-shouldered Hawk")

inat_data_list = list()

for(i in seq(otherbirds)){
  s = otherbirds[i]
  inat_data_list[[i]] = wklyobs(s, db="inat")
}

inatotherdata = bind_rows(inat_data_list)

ggplot(inatotherdata, aes(x = week, y =  y)) + 
  facet_wrap(~species, scales = "free_y") + 
  geom_point() + stat_smooth(se = FALSE) +
  xlab("week") + ylab("obs. count")  +
  ggtitle("Other birds: iNaturalist 2019")+ theme_bw(16)




otherbirds = c("Tree swallow",
               "Barn swallow",
               "Bushtit",
               "Bewick's wren",
               "Lesser goldfinch",
               "American dipper",
               "Western bluebird",
               "Northern mockingbird",
               #"Gray thrasher",
               "House sparrow",
               "American goldfinch"
               #"Northern cardinal"
               )

inat_data_list = list()

for(i in seq(otherbirds)){
  s = otherbirds[i]
  inat_data_list[[i]] = wklyobs(s, db="inat")
}

inatotherdata = bind_rows(inat_data_list)

ggplot(inatotherdata, aes(x = week, y =  y)) + 
  facet_wrap(~species, scales = "free_y") + 
  geom_point() + stat_smooth(se = FALSE) +
  xlab("week") + ylab("obs. count")  +
  ggtitle("Other birds: iNaturalist 2019")+ theme_bw(16)



otherbirds = c("California Quail",
               "Oregon Junco",
               "Steller's Jay",
               "Rock Pigeon",
               "Killdeer",
               "Elegant tern",
               "Pelagic cormorant",
               "Hooded merganser",
               "Willet"
               )

inat_data_list = list()

for(i in seq(otherbirds)){
  s = otherbirds[i]
  inat_data_list[[i]] = wklyobs(s, db="inat")
}

inatotherdata = bind_rows(inat_data_list)

ggplot(inatotherdata, aes(x = week, y =  y)) + 
  facet_wrap(~species, scales = "free_y") + 
  geom_point() + stat_smooth(se = FALSE) +
  xlab("week") + ylab("obs. count")  +
  ggtitle("Other birds: iNaturalist 2019")+ theme_bw(16)






mon = wklyobs('Monarch butterfly')

ggplot(mon, aes(x = week, y =  y)) + geom_point() + stat_smooth(se = FALSE) +
  xlab("Month") + ylab("obs. count")  +
  ggtitle(mon$species)+ theme_bw(16)


testplot = function(species){
  dat = wklyobs(species)
  
  gg = ggplot(dat, aes(x = week, y =  y)) + geom_point() + stat_smooth(se = FALSE) +
    xlab("Month") + ylab("obs. count")  +
    ggtitle(dat$species)+ theme_bw(16)
  
  return(gg)
}




plot_list = list()

for(i in seq(length(fallbirds))){
  f = fallbirds[i]
  plot_list[[i]] = testplot(f)
}

testplot("Red-tailed Hawk")

ggarrange(plot_list)

p = testplot("Bald Eagle")
p
testplot("Laysan albatross")
testplot("Golden Eagle")
testplot("Oak Titmouse")

