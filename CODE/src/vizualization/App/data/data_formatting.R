library(ncdf4)  
library(ncdf4.helpers)
library(data.table)

## Get the name of the value vars in the nc file
get_nc_value_name <- function(nc_file) {
  
  ## Get names
  nc_obj <- nc_open(nc_file)
  name<-names(nc_obj$var)
  
  ## Close file
  nc_close(nc_obj)
  
  ## Return the name
  return(name)
  
}

## Once we have the name of the variable we want to extract, we pass it onto this function to return the full dataset
xarray_nc_to_R <- function(nc_file, dimname, start=NA, count=NA, df_return = T) {
  
  ## Open the file and show the attribuets
  ncin <- nc_open(nc_file)
  print(ncin)
  
  ## Get the full array, using the variable name we want
  Rarray <- ncvar_get(ncin, dimname, start = start, count = count, collapse_degen=F)
  
  ## Get the fillvalue info
  fillvalue <- ncatt_get(ncin,dimname,"_FillValue")
  
  ## Get the dimension names in the right order
  array_dim <- ncdf4.helpers::nc.get.dim.names(ncin, dimname)
  
  
  ## Close the file
  nc_close(ncin)
  
  ## Get all of the dimension information in the order specified
  array_dim_list <- list()
  for(i in array_dim) {
    array_dim_list[[i]] <- ncin$dim[[i]]$vals
  }
  
  ## Fill in NaNs with NA
  Rarray[Rarray==fillvalue$value] <- NA
  
  
  ## Assign the dimension labels to the R array
  for(i in 1:length(array_dim_list)) {
    dimnames(Rarray)[[i]] <- array_dim_list[[i]]  
  }
  
  ## Attach the dimension name to the array
  names(attributes(Rarray)$dimnames) <- array_dim
  
  if(df_return) {
    return(data.frame(reshape2::melt(Rarray)))  
  } else {
    return(Rarray)  
  }
  
  
  
}


#/Users/nehabhatia/Documents/CSE_6242/App/data

#1us_precipitation_ann_forecast.nc
#2us_precipitation_climatology_forecast_singleday.nc
#3us_precipitation_cnn_forecast.nc
#4us_precipitation_forecast_true.nc
#5us_precipitation_hourly_climatology_forecast.nc
#6us_precipitation_lr_forecast.nc
#7us_precipitation_persistence_forecast.nc
#8us_precipitation_resnet_forecast.nc

#1us_temperature_ann_forecast.nc
#2us_temperature_climatology_forecast_singleday.nc
#3us_temperature_cnn_forecast.nc
#4us_temperature_forecast_true.nc
#5us_temperature_hourly_climatology_forecast.nc
#6us_temperature_persistence_forecast.nc
#7us_temperature_resnet_forecast.nc

# Precip1 
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_ann_forecast.nc"
dimname = get_nc_value_name(xarray_data)

precip1 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_ann_forecast.nc", dimname))

# Precip2 
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_climatology_forecast_singleday.nc"
dimname = get_nc_value_name(xarray_data)

precip2 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_climatology_forecast_singleday.nc", dimname))

# Precip3
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_cnn_forecast.nc"
dimname = get_nc_value_name(xarray_data)

precip3 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_cnn_forecast.nc", dimname))

# Precip4
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_forecast_true.nc"
dimname = get_nc_value_name(xarray_data)

precip4 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_forecast_true.nc", dimname))

# Precip5
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_hourly_climatology_forecast.nc"
dimname = get_nc_value_name(xarray_data)

precip5 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_hourly_climatology_forecast.nc", dimname))

# Precip6
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_lr_forecast.nc"
dimname = get_nc_value_name(xarray_data)

precip6 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_lr_forecast.nc", dimname))

# Precip7
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_persistence_forecast.nc"
dimname = get_nc_value_name(xarray_data)

precip7 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_persistence_forecast.nc", dimname))

# Precip8
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_resnet_forecast.nc"
dimname = get_nc_value_name(xarray_data)

precip8 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_resnet_forecast.nc", dimname))

# Temp1 
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_ann_forecast.nc"
dimname = get_nc_value_name(xarray_data)

temp1 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_ann_forecast.nc", dimname))

# Temp2 
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_climatology_forecast_singleday.nc"
dimname = get_nc_value_name(xarray_data)

temp2 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_climatology_forecast_singleday.nc", dimname))

# Temp3
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_cnn_forecast.nc"
dimname = get_nc_value_name(xarray_data)

temp3 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_cnn_forecast.nc", dimname))

# Temp4
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_forecast_true.nc"
dimname = get_nc_value_name(xarray_data)

temp4 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_forecast_true.nc", dimname))

# Temp5
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_hourly_climatology_forecast.nc"
dimname = get_nc_value_name(xarray_data)

temp5 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_hourly_climatology_forecast.nc", dimname))

# Temp6
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_persistence_forecast.nc"
dimname = get_nc_value_name(xarray_data)

temp6 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_precipitation_persistence_forecast.nc", dimname))

# Temp7
xarray_data <- "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_resnet_forecast.nc"
dimname = get_nc_value_name(xarray_data)

temp7 <- data.table(xarray_nc_to_R(nc_file = "/Users/nehabhatia/Documents/CSE_6242/App/data/us_temperature_resnet_forecast.nc", dimname))
