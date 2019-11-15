####
#### Created by Michalis Pavlis
####

source("/media/kd/Data/Dropbox/Repos/ahah_index/ahah_packs/data_packs.R")

####################################################################################################################################################
#                                                        Function 1: Add to metadata                                                               #
####################################################################################################################################################

add_to_metadata <- function(metadata_list, area_scale, area_code, area_name, geography_scale = "Town Centres", time_period, nation, keyword = NULL){
  metadata_list$titl <- paste("CDRC ", time_period, " Access to Healthy Assets & Hazards index (AHAH) - ", area_scale, " Geodata Pack: ", area_name,  " (", area_code, ")", sep="")
  metadata_list$abstract <- paste("This geodata pack provides the CDRC AHAH index for the year ", time_period, 
                                  " covering the ", area_scale, ": ", area_name, " (", area_code, ")",sep="")
  metadata_list$copyright = paste0(metadata_list$copyright,
                                   "\nContains LDC data 2016;",
                                   "\nContains CDRC data ",time_period, ";")
  metadata_list$dataCollector = c("Local Data Company")
  metadata_list$dataSrc = c(paste0(geography_scale, "CDRC AHAH index ", time_period))
  metadata_list$topcClas = paste("Health")
  metadata_list$geogUnit = "LSOAs"
  metadata_list$anlyUnit = "LSOAs"
  metadata_list$dataKind = c("Shapefile")
  metadata_list$serName = "AHAH index"
  metadata_list$timePrd = time_period
  metadata_list$geogCover = area_name
  metadata_list$relPubl = ""
  metadata_list$nation = nation
  metadata_list$keyword = c(area_code, area_name, "LDC", keyword, "boundary", time_period)
  return(metadata_list)
}

