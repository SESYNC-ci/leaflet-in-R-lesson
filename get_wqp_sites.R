# worksheet 1

library(dataRetrieval)
library(dplyr)

wqp_sites <- whatWQPsites(siteType = "Stream", statecode = "US:24")

wqp_orgs <- c("CBP_WQX", "MDE_FIELDSERVICES_WQX", "MDEDAT06_WQX", 
              "USGS-MD", "MDEDAT05_WQX", "MDE_EASP", "MDDNR")

wqp_sites_subset <- wqp_sites %>% 
  filter(OrganizationIdentifier %in% wqp_orgs,
         HorizontalCoordinateReferenceSystemDatumName != "UNKWN")

table(wqp_sites_subset$HorizontalCoordinateReferenceSystemDatumName)

head(wqp_sites_subset)

# also some incorrect coords (plot!)
sites_wgs84 <- wqp_sites_subset %>% 
  filter(HorizontalCoordinateReferenceSystemDatumName == 'WGS84')

sites_nad83 <- wqp_sites_subset %>% 
  filter(HorizontalCoordinateReferenceSystemDatumName == 'NAD83')

sites_nad27 <- wqp_sites_subset %>% 
  filter(HorizontalCoordinateReferenceSystemDatumName == 'NAD27')

# convert to sf with CRS info

sites_wgs84_sf <- st_as_sf(sites_wgs84,
                           coords = c("LongitudeMeasure", "LatitudeMeasure"),
                           crs = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
sites_nad83_sf <- st_as_sf(sites_nad83,
                           coords = c("LongitudeMeasure", "LatitudeMeasure"),
                           crs = '+proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs')
sites_nad27_sf <- st_as_sf(sites_nad27,
                           coords = c("LongitudeMeasure", "LatitudeMeasure"),
                           crs = '+proj=longlat +ellps=clrk66 +datum=NAD27 +no_defs ')

st_crs(sites_wgs84_sf)

sites_wgs84_sf
sites1 <- sites_nad27_sf %>% st_transform(st_crs(sites_wgs84_sf))
sites2 <- sites_nad83_sf %>% st_transform(st_crs(sites_wgs84_sf))

all_sites_wgs84 <- rbind(sites_wgs84_sf, sites1, sites2)

leaflet() %>%
  addTiles() %>%
  addMarkers(data = sites, clusterOptions = markerClusterOptions(), 
             popup = ~paste(MonitoringLocationName, OrganizationIdentifier))


# st_write(all_sites_wgs84, "wqp_sites.shp", "wqp_sites")
# 
# sites <- st_read("wqp_sites.shp")
# 
# leaflet() %>%
#   addTiles() %>%
#   addMarkers(data = sites, clusterOptions = markerClusterOptions(), 
#              popup = ~paste(MntrnLN, OrgnztI))

# water quality portal data
# downloaded using the `dataRetrieval` package from USGS
# see citation
#' @article{read2017water,
#'   title={Water quality data for national-scale aquatic research: The Water Quality Portal},
#'   author={Read, Emily K and Carr, Lindsay and De Cicco, Laura and Dugan, Hilary A and Hanson, Paul C and Hart, Julia A and Kreft, James and Read, Jordan S and Winslow, Luke A},
#'   journal={Water Resources Research},
#'   volume={53},
#'   number={2},
#'   pages={1735--1745},
#'   year={2017},
#'   publisher={Wiley Online Library}
#' }

