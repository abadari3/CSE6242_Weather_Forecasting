import climetlab as cml
import xarray as xr
import numpy as np

def normalize(x):
    try:
        mean = x.isel(time=slice(0, None, 10000)).mean().load()
        std = x.isel(time=slice(0, None, 10000)).std().load()
        return (x - mean)/std
    except:
        return (x - x.mean().load())/x.std().load()

def plot_temp(x):
    return cml.plot_map(
        data=x,
        foreground=dict(
            map_grid=False,
            map_boundaries=True,
        ),
        style=dict(
            contour = False,
            contour_hilo = False,
            contour_interval = 0.25,
            contour_label = False,
            contour_level_selection_type = 'interval',
            contour_shade = True,
            contour_shade_palette_name = 'eccharts_rainbow_purple_red_25',
            contour_shade_colour_method = 'palette',
            contour_shade_method = 'area_fill',
        ),
    )

def plot_rain(x): 
    cml.plot_map(
        data=x,
        foreground=dict(
            map_grid=False,
            map_boundaries=True,
        ),
        style=dict(
            contour = False,
            contour_hilo = False,
            contour_interval = 2,
            contour_label = False,
            contour_level_selection_type = 'interval',
            contour_shade = True,
            contour_shade_palette_name = 'eccharts_blue_purple_7',
            contour_shade_colour_method = 'palette',
            contour_shade_method = 'area_fill',
            contour_shade_min_level = 1,
        ),
    )
    
def compute_weighted_rmse(da_fc, da_true, mean_dims=xr.ALL_DIMS):
    """
    Compute the RMSE with latitude weighting from two xr.DataArrays.
    Args:
        da_fc (xr.DataArray): Forecast. Time coordinate must be validation time.
        da_true (xr.DataArray): Truth.
        mean_dims: dimensions over which to average score
    Returns:
        rmse: Latitude weighted root mean squared error
    """
    error = da_fc - da_true
    weights_lat = np.cos(np.deg2rad(error.lat))
    weights_lat /= weights_lat.mean()
    rmse = np.sqrt(((error)**2 * weights_lat).mean(mean_dims))
    return rmse