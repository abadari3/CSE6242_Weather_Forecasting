Weather and Climate Prediction using Machine Learning

DESCRIPTION 

Our package implements many different model architectures for longer-term weather prediction, using climate data going back 40+ years. We compare the efficacy of different models, and attempt to improve upon them. We are using the WeatherBench dataset (https://github.com/pangeo-data/WeatherBench). The WeatherBench Dataset consists of preprocessed meteorological data from ERA5 (https://www.ecmwf.int/en/forecasts/datasets/reanalysis-datasets/era5). We also use the CliMetLab package(https://github.com/ecmwf/climetlab). CliMetLab is a Python package aiming at simplifying access to climate and meteorological datasets, allowing users to focus on science instead of technical issues such as data access and data formats. Using these packages, we collect the 2m_temperature and total_precipitation data inside the bounding box of the continental United States. We train on all data until 2016, then use 2017 and 2018 as validation and testing datasets. We then visualize tests to predict December 2018. More information about the data can be found in 1-data-exploration.ipynb.

From here, we created many different baseline models. The first two, persistence and climatology, were baseline simplistic models. A persistence baseline is one where tomorrow's prediction is today's weather. A climatology forecast baseline averages historical data for a prediction that matches the climate of the region, but pays no attention to the dynamism of day to day weather. We also implemented a baseline Linear Regression model for prediction as well. These baselines are explored in 2-baselines.ipynb. Finally, in 3-artificial-neural-network.ipynb, 4-resnet.ipynb, we implement a Artificial Neural Network, Convolutional Neural Network, and a Residual Neural Network. Then, a combination of these models along with the climatology and persistence baselines are used to experiment with different ensemble models. Then, we evaluate our models with RMSE and Tracking Accuracy, as described in 6-evaluations.ipynb. Our core logic lies in the src/ folder. We have plotting and helper functions in utils. We define a Data Generator and pipeline in data.py. Additionally, ann.py, cnn.py, and resnet.py contain model architectures. We also have a results folder, where we have visualized our prediction results in an mp4. 

We have also developed a visualization tool to help visualize our data. The tool lives at https://nbhatia37.shinyapps.io/CSE_6242_Team035/. This tool displays the predicted temperature and precipitation for regions of the United States during December 2018. The user interacts with it by inputting a date between December 02, 2018 and December 31, 2018, as well as an hour between 0 and 23, to visualize the weather prediction for that date and time. The user can toggle whether to view the predicted precipitation in addition to the predicted temperature by clicking the "precipitation" checkbox in the left hand corner of the map. The tool was built in R using the packages Shiny and Shinythemes to build and format the live app, Leaflet and Leafletextras for displaying the predictions on a map, and Dplyr for processing and piping data.




INSTALLATION 

We can run the following commands on any conda-supported machine to create a new conda environment named weather, with python 3.8. Then, installing the requirements with pip installs the necessary dependencies. Note that if there is any error when installing requirements, then try conda install rather than pip install. Also, if your machine contains a GPU, install tensorflow-gpu rather than tensorflow. 

conda create --name weather python=3.8
conda activate weather
pip install -r requirements.txt




EXECUTION 

After executing the commands described above, the code demos can be run by running each jupyter notebook file in order, and following along with the instructions in each of those. Additionally, our github page (https://github.com/abadari3/CSE6242_Weather_Forecasting) has a branch called full. This branch holds a slightly different code organization structure, but has pretrained weights and specific predictions for each of the models. Using these would speed up any demos, as then a new model would not have to be trained. 

In order to demo the visualization tool, the code is provided under src/visualization/. The code used to build the app can be run in R Studio, and the app will pop up for usage locally. A demo can be run on the app from this point. We also hold a running demo at https://nbhatia37.shinyapps.io/CSE_6242_Team035/.