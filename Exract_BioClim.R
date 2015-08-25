### Extract BioClim climate data for specific lat/long coordinates
## WorldClim data from: http://www.worldclim.org/bioclim

# Required libraries
library(rgdal)
library(raster)

### Resolution options are 0.5 (30 arc seconds), 2.5, 5 and 10
## For res=0.5, lon and lat are required since the data are divided into global tiles

# To download the first time
BClim <- getData("worldclim", var="bio", lon = -80, lat = 35, res=0.5, path="~/Desktop")

# Define extent; 1)westernmost long, 2)easternmost long, 3)southermost, lat 4)northermost lat
Range <- (extent(-100, 0, 0, 60)) 

# Crop to defined extent
BClim <- crop(BClim, Range) 
writeRaster(BClim, filename="bioclim_0.5.grd", overwrite=T)

# To re-load cropped dataset, use 
BClim <- brick("bioclim_0.5.grd")

## Extract values for each of the 19 Bioclim variables for each lat long coordinate
# Pull BioClim values
coord <- read.csv("Desktop/file_name.csv", header=T)

coord_bc0.5 <- extract(BClim, coord)

coord_bc0.5 <- data.frame(lon=coord$Long, lat=coord$Lat, coord_bc0.5)

write.csv(coord_bc0.5, file="Desktop/coord_bioclim0.5.csv")




### For altitude values, change the var, and follow code above
Alt <- getData("worldclim", var="alt", lon=-80, lat=35, res=0.5, path="~/Desktop")




### To map each BioClim variable

# Change 1 to 2-19 for other variables
plot(BClim, 1, cex = 0.5, legend = T, mar=par("mar"), xaxt='n', yaxt = 'n', main = "Annual mean temperature (oC x 10)")

# or

plot(Alt, 1, ...)
