####
#### Created by Michalis Pavlis
####
library(sf)

source("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ahah_boundaries_functions.r")
source("/media/kd/Data/Dropbox/Repos/r_source/postgis_functions.r")

##############

## Clean shapefile & calc NA values of S01010206 LSOA using the average measures of Scotland in urban LSOAs
nc <- st_read("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ahah_data.shp")
colnames(nc) <- c("lsoa11cd",
               "r_dom",
               "h_dom",
               "e_dom",
               "ahah",
               "gpp_d",
               "ed_d",
               "dent_d",
               "pharm_d",
               "gamb_d",
               "ffood_d",
               "leis_d",
               "green900",
               "pubs2_d",
               "off2_d",
               "tobac_d",
               "no2",
               "pm10",
               "so2",
               "geometry")
st_write(nc, "/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ahah_data1.shp", driver = "ESRI Shapefile")

st_write(nc[,c(1:5)], "/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ahah_index.shp", driver = "ESRI Shapefile")



boundaries <- st_read("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ahah_data1.shp", stringsAsFactors = F)
names(boundaries)[1] <- "lsoa11cd"

boundaries_lad <- read.csv("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ahah_lut.csv", stringsAsFactors = F)
names(boundaries_lad)[1] <- "lsoa11cd"

lads <- st_read("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/LADs_2016/Local_Authority_Districts_December_2016_Generalised_Clipped_Boundaries_in_Great_Britain.shp", stringsAsFactors = F)

xml_template <- readLines("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/xml_doc.xml")

##### Create data pack ###############################################################################################################
# boundaries$cl_id2 <- as.integer(boundaries$cl_id2)
base_dir <- "/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/ckan"
create_data_pack(sf_df = boundaries, dt_lookup = boundaries_lad, base_dir = base_dir, sf_geom_column = "geometry",
                 sf_geog_unit_column = "lsoa11cd", dt_area_colunn = "laua", dt_geog_unit_column = "lsoa11cd", csv_tables = T)

for (lad_code in unique(boundaries_lad$laua)){
  nation <- ifelse(substr(lad_code, 1, 1) == "E", "England", ifelse(substr(lad_code, 1, 1) == "S", "Scotland", "Wales"))
  create_metadata(area_code = lad_code, area_name = lads[lads$lad16cd == lad_code, ]$lad16nm, area_scale = "Local Authority District",
                  geography_scale = "", time_period = "2016", base_dir = base_dir, xml_template = xml_template, metadata_list = metadata,
                  csv_tables = T, nation)
}
