import climetlab as cml

def normalize(x):
    mean = x.isel(time=slice(0, None, 10000)).mean().load()
    std = x.isel(time=slice(0, None, 10000)).std().load()
    return (x - mean)/std

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
