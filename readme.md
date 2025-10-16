# Data Analysis in Python for R Users — ReadMe

## Overview

This project provides a rough tutorial for performing data analysis in Python for people accustomed to `dplyr` style syntax in `R`. It is separated into two Jupyter notebooks — `demo-r.ipynb` and `demo-py.ipynb` — the former running on an `R` kernel, and the latter using a `python` kernel.   

Each notebook follows nearly identical steps in loading, cleaning, and analyzing one day's worth of calls for service (CFS) data for the City of New Orleans. There is a brief introduction to the syntax and grammar of each language, followed by various data cleaning  steps, and finishing with a rudimentary exploratory analysis of the cleaned dataset.  

The `R` notebook primarily uses `dplyr` and other `tidyverse` libraries for cleaning and analysis, while the `Python` notebook uses primarily `siuba` and some `pandas` functionality to follow the same processing steps.  

For reproducibility, this repository has a conda environment file `environment.yml` for creating a `Python` environment with all of the required packages listed out (See `Running this Notebook` for usage).  For the `R` environment, included is a one-click file `install_dependencies.R` for setting up all of the required libraries.  

**Note**: This project is not intended to serve as a tutorial for `R` or `Python` due to the specialized nature of the libraries and functions covered. Specifically, `R` users are encouraged to have a comfortable understanding of base `Python` functionality before diving into the `siuba` library. However, these notebooks can also serve as a guide for `Python` users interested in `dplyr` focused data analysis in `R`.

## File Structure

```bash
python-for-r-users
╠══ data/                                          # Holds all input data
║   ╠══ shapes/                                    # Holds new orleans shapefile(s)
║   ║   ╠══ tl_2024_22_bg.cpg
║   ║   ╠══ tl_2024_22_bg.dbf
║   ║   ╠══ tl_2024_22_bg.prj
║   ║   ╠══ tl_2024_22_bg.shp
║   ║   ╠══ tl_2024_22_bg.shp.ea.iso.xml
║   ║   ╚══ tl_2024_22_bg.shx
║   ╚══ calls_for_service_2025_demo.csv            # Calls for service sample set
╠══ .git-nbconfig.yaml                             # Specifies rules for nbstripout-fast
╠══ .gitattributes                                 # Enables git filter for notebooks
╠══ demo-py.ipynb                                  # Notebook for Python data analysis 
╠══ demo-r.ipynb                                   # Notebook for R data analysis
╠══ environment.yml                                # Run file for conda environment
╠══ install_dependencies.R                         # Run file for R packages
╚══ readme.md                                      # Project readme (you are here!)
```

## About the Data

The CFS demo dataset included in the `data` folder in the project directory is a truncated version of the 2025 CFS dataset made publicly available at `data.nola.gov`. Specifically, it consists of the `857` unique calls for service incidents occuring on January 1, 2025. There are twenty-one columns in the original dataset, as follows:
 - NOPD_Item — The unique item number (eg, A0001925) assigned by NOPD for the incident
 - Type — The CAD code (eg 94, 62A) assigned to the incident
 - TypeText — A description (eg, BURGLARY, DEATH) of the CAD code assigned to the incident
 - Priority — The priority level assigned to the incident (eg, 1A, 2J)
 - InitialType  — The initial CAD code associated with the incident
 - InitialTypeText — A description of the initial CAD code associated with the incident
 - InitialPriority — The initial priority level associated with the incident
 - MapX — An obscured state plane x-value for the incident
 - MapY — An obscured state plane y-value for the incident
 - TimeCreate — The time the incident was initiated in the NOPD's CAD system
 - TimeDispatch — The time an officer was dispatched to respond to the incident
 - TimeArrive — The time an officer is reported to have arrived at the incident
 - TimeClosed — The time an officer marked the incident as closed (resolved) 
 - Disposition — The status of the incident at the time of incident closure (eg, REPORT TO FOLLOW, GONE ON ARRIVAL)
 - SelfInitiated — Whether an officer initiated the incident themselves as a response to something in the field (Y), or whether a 911 call initiated the incident (N)
 - Beat — The beat (eg, 5A04) where the call occured; the first number is the NOPD District, the letter is the zone, and the numbers are the subzone
 - BLOCK_ADDRESS — The semi-obscured block address (eg, 020XX Tupelo St) where the incident originated from
 - Zip — The zip code where the incident originated from 
 - PoliceDistrict — The police district where the incident originated from
 - Location — Point data, eg POINT (-90.123456, 30.123456), indicating longitude and latitude where the incident originated from

## Prerequisites

### 1. R 

This project runs on `R` `4.4.3`, but I'm not aware of any version incompatibilities. Download can be found [here](https://cran.r-project.org/bin/windows/base/old/4.4.3/).

And ensure `R` is added to your `PATH` — this requires administrative privileges, but can be done following this [guide](https://www.hanss.info/sebastian/post/rtools-path/).

### 2. R Kernel for Jupyter — IRkernel

This analysis uses IRkernel, which is an `R` kernel for Jupyter. Install is handled in the `install_dependencies.R`, but the user must ensure that their IDE and detect the kernel. 

TO-DO: Update IRkernel with updated instructions

### 3. Python 

The `Python` notebook was written with `3.13.7` in mind, which is what is specified in the `environment.yml` setup file.

### 4. Conda 

This project uses a Conda environment for `Python` version control. I recommend using [Miniconda](https://www.anaconda.com/docs/getting-started/miniconda/main) as it's a lightweight alternative to the more feature-rich [Anaconda](https://www.anaconda.com/).

### 5. A Jupyter-compatible IDE

Options include:
 - VS Code / Positron (my recommendation)  
     - VS Code will require the `Jupyter` and `R` extensions from the marketplace
 - JupyterLab  
 - Jupyter Notebook  

## Required Libraries

### R
1. `tidyverse` — for tidy data manipulation and visualization
2. `naniar` — for identifying and replacing missing values as `NA`
3. `glue` — for handy string interpolation
4. `tidygeocoder` — for geocoding missing location data
5. `sf` — for handling spatial feature (sf) objects

### Python
1. `pandas` — for data manipulation 
2. `re` — for `regex` handling 
3. `math` — for some non-base calculations
4. `numpy` — for numerical data handling
5. `pyjanitor` — for standardizing column names
6. `siuba` — for `dplyr` styled data manipulation
7. `geopandas` — for geocoding missing location data
8. `geopy` — a helper library for `geopandas`
9. `plotnine` — for `ggplot2` styled data visualization 
10. `statsmodels` — for `R` styled statistical modeling 

## Project Structure

### 0. Environment Setup
1. Loading a library
2. Defining custom functions — Defines the following helper functions:
   - `affiche()` — Generates an aesthetic table; from the French *affiche* to display something
   - `count_table()` — Generates a count table for any column in a dataset
   - `count_na()` — Counts `NA` values for each column in a dataset
   - `describe()` — Provides summary statistics for numeric columns in a dataset
     - This function only exists in the R notebook and is meant to mimic the `Pandas` function `describe()`

### 1. Simple Data — This provides some of the most rudimentary basics of each language

### 2. Working with Dataframes — This section creates a sample dataframe and demonstrates simple data manipulation 

### 3. More Advanced Manipulation — This portion completes the following steps in the data preparation process
1. Reading in data — Reads in the calls for service demonstration set 
2. Cleaning column names — Standardizes and manually renames various column names, like changing `TypeText` to `type_text`
3. Converting character fields to sentence case — Converts fields like `REPORT TO FOLLOW` to `Report to follow`
4. Re-casting data types — Ensures columns exhibit the most appropriate data type, such as re-casting date fields as actual dates
5. Replacing missing values — Identifies placeholders for missing values (like `0`, or `None`) and assigns them the appropriate `NA` value
6. Using `regex` to update a column — Updates the beat column to fix broken values with string extraction, like altering `1.00e+03` to display `1e03`
7. Creating booleans — Transforms the self-initiated column from Y/N to a boolean (True/False)
8. Extracting coordinate info — Utilizes string extraction to parse longitude and latitude information from the location column
9. Geocoding missing location data — Geocodes addresses which lack valid location data, providing estimated point location data via `ArcGIS`
10. Calculating response time — Creates a column for tracking the time between call initiation and officer arrival for each incident
11. Collapsing call priorities — Assigns a description for each incident's call priority (eg, `0` is recoded as "Non-police")
12. Classifying call types — Classifies calls as violent, theft, traffic, or other 

### 4. Exploratory Data Analysis — Lastly, this section answers some questions that might come up when analyzing this sort of data
1. Summary statistics
2. What are the most commonly occuring call type categories?
3. When do most calls take place?
4. What are the most common call dispositions?
5. Which police districts receive the most calls?
6. What proportion of calls are self-initiated?
7. Where do most calls originate from?
8. What is the best predictor of response time?

## Running this Notebook

0. **Install prerequisites**
   - R
   - Python
   - Conda
   - A Jupyter-friendly IDE

1. **Clone this repository**
   ```bash
   git clone https://github.com/CBurruss/python-for-r-users.git
   cd python-for-r-users
   ```

2. **Create Python conda environment**
   ```bash
   conda env create -f environment.yml
   conda activate py-for-r
   ```

3. **Install R dependencies**
    ```R
    source("install_dependencies.R")
    ```

4. **Open the notebook files in your IDE**
    - Select appropriate kernel for each notebook
    - Run each cell in order (`▷ Run All`)
