# Urban Water and Sanitation Survey

[![GitHub top language](https://img.shields.io/github/languages/top/validmeasures/wash.svg)]()
[![GitHub release](https://img.shields.io/github/release/validmeasures/wash.svg)](https://github.com/validmeasures/wash/blob/master/NEWS.md)
[![license](https://img.shields.io/github/license/validmeasures/wash.svg)](https://github.com/validmeasures/wash/blob/master/LICENSE.md)
[![Github All Releases](https://img.shields.io/github/downloads/validmeasures/wash/latest/total.svg)](https://github.com/validmeasures/wash/archive/master.zip)

<br/>

Project on developing sampling and survey methods to assess **water, sanitation and hygiene (WASH)** indicators in urban areas. Project commissioned by [Water and Sanitation for the Urban Poor (WSUP)](http://www.wsup.com).

This repository provides the analysis workflow for producing WASH indicator results from datasets collected in the various [WSUP](http://www.wsup.com) focus cities i.e., Dhaka, Bangladesh; Accra, Ghana; Nakuru, Kenya; Antananarivo, Madagascar; Maputo, Mozambique; and, Lusaka, Zambia.

Currently, the sampling and survey methods have been tested and implemented in Dhaka, Bangladesh. Analysis is performed using [R](https://www.r-project.org) and should be implemented using the [RAnalyticFlow](http://r.analyticflow.com/en/) IDE.

<br/>

## Getting Started

Clone or download this repository into your computer. If you used download, unzip the contents of the downloaded **`wash`** ZIP folder into a directory on your computer making sure that all contents are organised in the same way as they were in the folder provided.

[R](https://www.r-project.org) is directory-specific and most of the commands in the workflow and in the additional [R](https://www.r-project.org) scripts were written in such a way that is oriented to the directory structure of the provided data package.

### Prerequisites

This analysis workflow requires that:

1. You have a computer running the latest version of [R](https://www.r-project.org). Whilst [R](https://www.r-project.org) can run on the specifications of most computers, given the highly computational statistical approach to estimation and mapping used in the workflow and other analysis, we recommend at least a dual core machine with a minimum of ```4GB RAM```.

To install [R](https://www.r-project.org), visit the [CRAN website](http://cran.r-project.org/mirrors.html) for instructions.

Once you have installed [R](https://www.r-project.org), you will need to install [RAnalyticFlow](http://r.analyticflow.com/en/), the IDE on which the main analysis workflow was built on. For instructions on how to install and launch [RAnalyticFlow](http://r.analyticflow.com/en/), see these tutorials on [installation](https://validmeasures.nyc3.digitaloceanspaces.com/tutorials/rFlowInstall.pdf) and [launching](https://validmeasures.nyc3.digitaloceanspaces.com/tutorials/rFlowLaunch.pdf) of the software.

2. You have performed an urban survey in one of the [WSUP](http://www.wsup.com) cities based on the survey design developed for [WSUP](http://www.wsup.com) by [Valid International, Ltd](http://www.validinternational.org) and using the questionnaire developed by [WSUP](http://www.wsup.com) for this specific purpose. If your data is collected from a different survey with a different design and/or is based on a different questionnaire, this analysis workflow will most likely not be able to analyse your data. If you haven't performed a survey yet but would be in the future, contact [Jonathan Stokes](mailto:jstokes@wsup.com) for further assistance on survey design and survey instruments.

3. You have two survey datasets: 

* dataset collected using the [WSUP](http://www.wsup.com)- designed questionnaire containing information provided by households; and,

* dataset on estimated population of each primary sampling unit (PSU) that were surveyed. Both datasets should have a matching variable labelled as **`psu`** denoting the unique identifier for each of the PSUs in the survey.

The survey dataset should have exactly the same structure as the data that is created by the [mWater](http://www.mwater.co) data collection system setup by [WSUP](http://www.wsup.com) and that was used for the Bangladesh pilot survey. Any changes to this standard questionnaire that changes the internal data structure of the survey dataset will result, at the very least, in analysis not to be possible for specific data elements whose structure has been changed and at worst case, break the analysis workflow without any analysis output produced unless corresponding modifications are implemented. Any changes to this standard questionnaire that adds variables to the dataset (without affecting the internal structure of the dataset itself) will most likely result in the added variables not being analysed unless corresponding modifications are made on the analysis workflow to deal with the added variables. However, if such additional variables are in someway linked to the standard variables and is required for producing analysis, then this is the same as changing the internal structure of the dataset and will result in the workflow being unable to produce any analysis outputs without corresponding modifications to the analysis workflow.

The population data should also have as a minimum a variable providing the population estimate for each of the PSUs denoted as variable **`pop`** and a variable providing the survey area groupings of the different PSUs denoted as variable **`zone`** and a variable providing information on the type of survey area (i.e., whether slum or citywide sample) denoted as variable **`type`**.  Both variables **`zone`** and **`type`** should be encoded as numeric. For **`zone`**, it would be a number from 1 to ***`n`*** (where ***`n`*** is the number of survey areas defined during the survey) that has been assigned to each survey area. For **`type`**, it should be a binary numeric encoding with 1 assigned to a slum sampling area and 2 assigned to the general citywide sample. 

As an example, the Dhaka survey and population dataset is provided also in this repository (**`surveyDataBGD.csv`** and **`popBGD.csv`**).

<br/>

## Running the analysis

For instructions on how to run the workflow in [RAnalyticFlow](http://r.analyticflow.com), see these tutorials on [opening a workflow](https://validmeasures.nyc3.digitaloceanspaces.com/tutorials/rFlowOpenWSUP.pdf) and [running a workflow](https://validmeasures.nyc3.digitaloceanspaces.com/tutorials/rFlowRunWSUP.pdf).

[RAnalyticFlow](http://r.analyticflow.com) is an interactive development environment (IDE) for [R](https://www.r-project.org). It allows for entry level [R](https://www.r-project.org) users to use [R](https://www.r-project.org) using a more familiar point and click and menu-based user interface. For the WSUP analysis workflow, the scripts have already been setup in such a way that it walks you through the different steps of the analysis. The workflow has been laid out non-traditionally in that instead of one flow of all the steps of the analysis, it has been broken down into multiple flows organised into logical flow steps (i.e., input, process, analyse, output) that need to be undertaken to complete the process. These steps are identified as unique rows of workflows marked with a star at the end of the row labelled as chronological steps (e.g., Step 1, Step 2...). These steps should be initiated and run chronologically as well. This can be done by selecting the star icon of the step to be initiated and then clicking on the **`Run Flow`** button or by hitting **`CTRL + SHIFT + R`** on your keyboard.


### 1. Step 0: Install packages

If you are using the workflow for the first time, Step 0 is required or mandatory to be initiated. Step 0 installs the various packages needed for the [WSUP](http://www.wsup.com) analysis workflow to work. This workflow requires certain libraries of code/functions created by various individuals and organisations for different purposes. Some libraries are installed into [R](https://www.r-project.org) by default and can be called into a current [R](https://www.r-project.org) workspace by using the **`library()`** function. For others, the required packages need to be installed first into [R](https://www.r-project.org) before they can be called into a current [R](https://www.r-project.org) workspace using the **`library()`** function. The installation of the packages need to be done only once. Once installed, these packages can be called into a current [R](https://www.r-project.org) workspace using the **`library()`** function.                                           

The following packages need to be installed first before continuing on with the next steps/nodes for analysis. If these packages are already installed in the [R](https://www.r-project.org) in your machine, you can opt to skip this step/node. Running this step/node even if you have the packages installed in the [R](https://www.r-project.org) in your machine just re-installs these packages and does not in any way affect [R](https://www.r-project.org) and its capabilities. The following command to install packages will be downloaded from the internet and installed locally into your machine. If unable to download the packages, a prompt will be shown to install packages from a local source (i.e., package files saved in your computer or on a drive).

### 2. Step 1: Setup

This step specifies [R](https://www.r-project.org) properties, libraries and dependencies required by this analysis, various functions and various utilities and specifications that will be called upon in the latter sections of this workflow.

This step is required and mandatory every time the [WSUP](http://www.wsup.com) analysis workflow is used. This step is composed of eight nodes or sub-steps.


#### a. Configure [R](https://www.r-project.org)
This step resets all [R](https://www.r-project.org) settings, clears the [R](https://www.r-project.org) cache in your computer's random access memory (RAM) and sets a random number seed for any function requiring a random number to be generated. All these settings ensures that you are working with [R](https://www.r-project.org) with clear settings avoiding potential common conflicts when previous operation/s have been performed in [R](https://www.r-project.org)/[RAnalyticFlow](http://r.analyticflow.com).


#### b. Load libraries
This step loads the libraries needed by the analysis workflow to perform the required analysis. Most of these are the same libraries that have been installed in Step 0. The others are base functions already pre-installed with any R installation.


#### c. Functions
This step loads functions that have been created to work with the [WSUP](http://www.wsup.com) analysis workflow. Most important of these functions is the blocked weighted bootstrap algorithm that serves as the estimator function for the indicators produced by this workflow. For further explanation on the blocked weighted bootstrap estimator, see the design document produced by [Valid International](http://www.validinternational.org). A copy can be requested from [Jonathan Stokes](mailto:jstokes@wsup.com).

#### d. Directories
This step automatically generates directories within the current working directory to which the workflow will save its outputs. There are three directories that are created:

* **`outputLists`** - this directory is used to store the codebook created in the next steps;

* **`outputTables`** - this directory is used to store the results tables produced by the analysis workflow;

- **`data`** - this directory is used to store processed datasets produced by the analysis workflow.

#### e. Assemble colours
This step creates colour palettes that will be used by other later steps in the workflow. This step is now deprecated as outputs requiring colours are now produced by the web-based application created for the urban water and sanitation surveys of [WSUP](http://www.wsup.com).

#### f. PPI tables
This step is a data node. This node contains the datasets for the lookup tables to be used for calculating the **`Progress out of Poverty Index (PPI)`**. This step is a critical step and should not be altered for any reason unless person doing so knows what they are doing and knows the implications of their changes.

#### g. Choose country
This step produces a dialog box that prompts user to provide specific information which in this case is the country in which the survey has been done. Currently, the survey instruments/questionnaires that are standard for the WSUP Urban Water and Sanitation Surveys doesn't record information in terms of the country and the city in which the survey is being performed (something that is critically incorrect and unacceptable in a standard questionnaire which is meant to be used in different settings and locations). To address this issue, the user of this analysis workflow appropriates the country to which the current dataset to be processed pertains to. It should be noted how critically important it is that the appropriate country be selected as this will have an impact in the subsequent steps in the workflow.

#### h. Get country name
Once the user provides the country, this information is processed and the workflow extracts this information and adds information into the dataset so that it will now contain country and city location information. This step is dependent on the input in **`g`**.


### 3. Step 2a: Read survey data

This step asks the user to provide the survey dataset for the analysis. This will be the dataset collected using the questionnaire created by WSUP for the urban water and sanitation surveys. The survey dataset should have the variable named **`psu`** which is the identifying information for the primary sampling units of the survey. It is important to ensure that the variable names are kept as specified above as this variable name will be used to match this survey dataset to the population dataset in later steps. The user will be prompted and guided through the data selection process. If no data file is selected or the wrong data file type is selected (data file should be in comma-separated value or CSV format), user will be prompted and warned accordingly. The survey dataset is required to be able to proceed with the next steps of the workflow.

### 4. Step 2b: Read and process data

This step is an interim or sub-step. Raw cleaned survey data is processed and then saved as working data in the 'data' folder in the working directory. Codebooks are also produced for dataset documentation purposes and as reference. This is saved in the **`outputLists`** folder. Data processing need only be done once as working details used for subsequent steps.

It should be noted that this processing step is specific to the Dhaka, Bangladesh survey conducted in March 2017. Because of the nature of the questionnaire and how specific questions are asked and the responses provided, Dhaka-specific cleaning and processing of the data were performed. This step will most likely not work for other country surveys as no information is still known as to what kinds of inputs and responses will be provided by the respondents in the other countries.

### 5. Step 3: Indicators

This step recodes survey data and calculates the various indicators based on the analysis that will be done. Indicator sets produced are:                                              

a. **Poverty indicator** - based on Progress out of Poverty Index

b. **Water indicators** - based on post-2015 Joint Monitoring Programme indicator set and on WSUP-created indicator sets

c. **Sanitation indicators** - based on post-2015 Joint Monitoring Programme indicator set and on WSUP-created indicator sets

d. **Handwashing indicators** - based on post-2015 Joint Monitoring Programme indicator set and on WSUP-created indicator sets

e. **Hygiene indicators** - based on post-2015 Joint Monitoring Programme indicator set and on WSUP-created indicator sets

Indicator sets are merged into a single indicator dataframe and is saved as a **`comma-separated value (CSV)`** file in the **`data`** folder in the working directory. If you have any further queries with regard to the poverty indicators, visit the PPI website for further information. For further queries on water, sanitation and hygiene indicators, enquire from WSUP for their extensive documentation on their water, sanitation handwashing and hygiene indicators.

### 6. Step 4a: Classify

This step is part of the last steps of the workflow that analyses the data and produces indicator results. This step specifically performs a **`lot quality assurance sampling (LQAS)`** classification process that determines whether an indicator proportion results meets a specific standard or cut-off. If the indicator result is below standard, then it is classified as being low or a failure. If the indicator result is above standard then it is considered high or a success.

Classification of results for proportion-type of indicators was first recommended as the option to use given the limited set of resources available to WSUP to perform the surveys thy set out to implement.

When initiating this step, the user is first prompted to provide the following information:

a. **Steering file** - the user will be asked to provide the steering file that maps out the indicator sets that will be analysed. This steering file was created based on the WSUP standard indicator sets. A copy of this steering file is available from this repository and can be used for all other city survey data.

b. **Indicator data** - the user will be asked to provide the indicator data file. This will be the indicator data that has been produced in Step 2b. This can be found in the 'data' folder in the current working directory.

c. **Population data** - the user will be asked to provide the population data file. This is the file described in the introduction. It should be noted that the population data file needs to be in the exact format described earlier specifically the variable names and the required data columns for it to be properly used in the analysis. Note also that for classification, the population data is not used but the user is still asked to provide this information.

Once the datasets have been provided, the next steps involve the actual classification of results. The different steps in this are:

a. **Specify LQAS parameters** - the user will be asked to specify two cut-off points to which results will be classified. The default upper and lower standards are 50% and 80%. For further information on how to properly set LQAS standards, refer to the design document that is available from WSUP through [Jonathan Stokes](mailto:jstokes@wsup.com).

b. **Classify by area** - this step classifies the indicator data disaggregated by survey area. This step breaks the data into the different survey areas and performs the classification on each of the datasets for each survey area for each of the indicators. All results for each survey area and for each indicator is combined in a single data frame and saved as a CSV file in the **`outputTables`** folder found in the current working directory under the filename **`surveyResultsClassXXXMmmYYYY.csv`** where:

```

   XXX  - three letter ISO country code (i.e., Bangladesh - BGD)

   Mmm  - three letter abbreviation of the month in which the 
          survey that the dataset being analysed comes from was 
          started.

   YYYY - four digit number corresponding to the year in which 
          the survey that the dataset being analysed comes from 
          was started.

```

c. **Classify by wealth** - this step classifies the indicator data disaggregated by wealth quintiles. This step breaks the data into the different quintiles and performs the classification on each of the datasets for each wealth quintile for each of the indicators. All results for each wealth quintile and for each indicator is combined in a single data frame and saved as a CSV file in the **`outputTables`** folder found in the current working directory under the filename **`surveyResultsClassWealthXXXMmmYYYY.csv`** where:

```

   XXX  - three letter ISO country code (i.e., Bangladesh - BGD)

   Mmm  - three letter abbreviation of the month in which the  
          survey that the dataset being analysed comes from was 
          started.

   YYYY - four digit number corresonding to the year in which 
          the survey that the dataset being analysed comes from 
          was started.

```

d. **Classify overall** - this step classifies the indicator data for the whole dataset. Classification is performed on each of the indicators using the full dataset. All results for each indicator is combined in a single data frame and saved as a CSV file in the **`outputTables`** folder found in the current working directory under the filename **`surveyResultsClassOverallXXXMmmYYYY.csv`** where:

```

   XXX  - three letter ISO country code (i.e., Bangladesh - BGD)

   Mmm  - three letter abbreviation of the month in which the 
          survey that the dataset being analysed comes from was 
          started.

   YYYY - four digit number corresponding to the year in which 
          the survey that the dataset being analysed comes from 
          was started.

```

Another node called **`Classify by corporation`** performs classification by north and south corporations of Dhaka, Bangladesh. This step is Dhaka-specific and should be initiated on its own if a north and south classification is required.

### 7. Step 4b: Estimate

This step is part of the last steps of the workflow that analyses the data and produces indicator results. This step specifically performs a **`blocked weighted bootstrap`** estimation of indicator results and a **`95% confidence interval (CI)`**  around the estimate. This approach was added to the analysis to test the viability of an estimation approach for small sample sizes.

When initiating this step, the user is first prompted to provide the following information:

#### a. Steering file
The user will be asked to provide the steering file that maps out the indicator sets that will be analysed. This steering file was created based on the WSUP standard indicator sets. A copy of this steering file is available from this repository and can be used for all other city survey data.

#### b. Indicator data
The user will be asked to provide the indicator data file. This will be the indicator data that has been produced in **`Step 2b`**. This can be found in the **`data`** folder in the current working directory of the workflow.

#### c. Population data
The user will be asked to provide the population data file. This is the file described in the introduction. It should be noted that the population data file needs to be in the exact format described earlier specifically the variable names and the required data columns for it to be properly used in the analysis. Note also that for classification, the population data is not used but the user is still asked to provide this information.

Once the datasets have been provided, the next steps involve the actual estimation of results. The different steps in this are:

#### a. Specify bootstrap parameters
The user will be asked to specify the number of replicates to perform for bootstrap estimation. The default is 399 replicates. It is recommended that the number of replicates be no less than this default number. For further information on setting bootstrap replicates, refer to the design document that is available from [WSUP](http://www.wsup.com) through [Jonathan Stokes](mailto:jstokes@wsup.com).

#### b. Estimate by area
This step classifies the indicator data disaggregated by survey area. This step breaks the data into the different survey areas and performs the estimation on each of the datasets for each survey area for each of the indicators. All results for each survey area and for each indicator is combined in a single data frame and saved as a CSV file in the **`outputTables`** folder found in the current working directory under the filename **`surveyResultsXXXMmmYYYY.csv`** where:

```

   XXX  - three letter ISO country code (i.e., Bangladesh - BGD)

   Mmm  - three letter abbreviation of the month in which the 
          survey that the dataset being analysed comes from was 
          started.

   YYYY - four digit number corresonding to the year in which 
          the survey that the dataset being analysed comes from 
          was started.
```

#### c. Estimate by wealth
This step estimates the indicator data disaggregated by wealth quintiles. This step breaks the data into the different quintiles and performs the estimation on each of the datasets for each wealth quintile for each of the indicators. All results for each wealth quintile and for each indicator is combined in a single data frame and saved as a CSV file in the **`outputTables`** folder found in the current working directory under the filename **`surveyResultsWealthXXXMmmYYYY.csv`** where:

```

   XXX  - three letter ISO country code (i.e., Bangladesh - BGD)

   Mmm  - three letter abbreviation of the month in which the 
          survey that the dataset being analysed comes from was 
          started.

   YYYY - four digit number corresonding to the year in which 
          the survey that the dataset being analysed comes from 
          was started.

```

#### d. Estimate overall
This step estimates the indicator data for the whole dataset. Estimation is performed on each of the indicators using the full dataset. All results for each indicator is combined in a single data frame and saved as a CSV file in the **`outputTables`** folder found in the current working directory under the filename **`surveyResultsOverallXXXMmmYYYY.csv`** where:

```

   XXX  - three letter ISO country code (i.e., Bangladesh - BGD)

   Mmm  - three letter abbreviation of the month in which the 
          survey that the dataset being analysed comes from was 
          started.

   YYYY - four digit number corresponding to the year in which 
          the survey that the dataset being analysed comes from 
          was started.

```

Another node called **`Estimate by corporation`** performs estimation by north and south corporations of Dhaka, Bangladesh. This step is Dhaka-specific and should be initiated on its own if a north and south estimation is required.

### 8. Step 4c: Combine results

This step is the final step in the analysis process. This step looks for all the outputted results for classification and estimation at the different levels of disaggregation and combines them into a single data frame. Once combined, a further organisation of data is performed that converts the data frame into a format that is acceptable to the web application that will produce visualisation outputs from the results. This final data frame is saved in the **`outputTables`** folder under the filename **`surveyResultsAll.csv`**. This file has no location and time identifiers as it combines all completed results from all country surveys at all time periods.

<br/>

## Built With

* [R](https://www.r-project.org)
* [RAnalyticFlow](http://r.analyticflow.com)

<br/>

## Authors

**Laura Bramley** - [Valid International, Ltd.](http://www.validinternational.org)

**Ernest Guevarra** - [Valid International, Ltd.](http://www.validinternational.org)

<br/>

## Collaborators

**Jonathan Stokes** - [WSUP](https://www.wsup.com)

<br/>

## Contributing to the project

To contribute to the project, read and follow the steps for making contributions found [here](https://github.com/validmeasures/wash/blob/master/.github/CONTRIBUTING.md). Also, make sure that you read and follow the [Code of Conduct](https://github.com/validmeasures/wash/blob/master/.github/CODE_OF_CONDUCT.md) that governs collaboration in this project.

For any questions on how to contribute to the project, contact [Ernest Guevarra](mailto:ernest@validinternational.org).

<br/>

## License

This project is licensed under the [AGPL-3.0 License](https://github.com/validmeasures/wash/blob/master/LICENSE.md).
