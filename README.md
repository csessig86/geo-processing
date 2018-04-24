# Working with geo data

This repo shows how you can use command line tools to work with geographical data. The nice thing about this approach is it's repeatable, meaning you can run it over and over again without needing to do any manual work. You can also add in new data and only need to make a small change or two inside your script to re-run your entire analysis. This is not possible with GUIs like Excel or OpenOffice.

For this example, we'll finding all the census tracts within Congressional District 27 and merging in Hispanic population data for each tract. With this data, you could create a choropleth map like we did at the Texas Tribune for [this redistricting project](https://apps.texastribune.org/texas-congressional-district-27-redistricting-hispanic-voters/).

The analysis is contained within a bash file. The tasks can be ran using the following command:

```
sh process.sh
```

We use a command line tool called [ogr2ogr](http://www.gdal.org/ogr2ogr.html), which is great for doing all sorts of cool things with geography files like shapefiles. In this project, we will be using it to run SQL queries.

### 1. Getting census tracts within CD-27

We will start with two shapefiles:
* All the [census tracts](https://www.census.gov/cgi-bin/geo/shapefiles/index.php?year=2017&layergroup=Census+Tracts) in the state of Texas: raw_data/tracts.shp
* The [shape](http://www.tlc.texas.gov/redist/data/data.html) of Congressional District 27: raw_data/cd27.shp

We will run a SQL query using ogr2ogr to find all of the census tracts within the shape of Congressional District 27. To do this, the command will go through each of Texas's census tracts; if it finds the geography of the tract is within the geography of CD-27, the script will add that tract to a new file. Otherwise, it will ignore. The resulting file will be only tracts within CD-27.

This file is exported into the edits directory.

### 2. Merge tracts with population data

We also have one csv for this analysis:

* The percentage of [Hispanic residents](https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml) in each Texas census tract: raw_data/hispanic_population.csv

We will perform a [SQL join](https://www.w3schools.com/sql/sql_join.asp) to merge this csv with the exported shapefile from step 1. These files have a similar field of geoid, which will allow us to match the tracts from both datasets and merge.

The result is a shapefile of tracts within CD-27, as well as each tract's Hispanic population.

This file is exported into the edits directory.

### 3. Export

The final step is to get this file into a format that we could use for an online map. One common filetype is geojson, which can be read using javascript. We will use ogr2ogr to convert our newly-created shapefile into a geojson file.




