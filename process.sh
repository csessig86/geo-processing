# This is the file where all of our analysis takes place

# We'll first jump into our raw_data directory, where all of these files live
cd raw_data

# This is the command for: 1. Getting census tracts within CD-27
# The first parameter (tracts_within_cd27.shp) is the name of the file we're creating
# The second parameter (raw.vrt) is a file that has information on the two shapefiles we're using:
# cd27.shp, which is the shapefile of Congressional District 27
# tracts.shp, which is the shapefile of Texas census tracts
# We then tell ogr2ogr to run a sqlite query
# With the ST_Intersects query, we can find all the census tracts with Congressional District 27
ogr2ogr tracts_within_cd27.shp raw.vrt -dialect sqlite -sql "SELECT * FROM tracts, cd27 WHERE ST_Intersects(tracts.geometry, cd27.geometry)" tracts.shp


# This is the command for: 2. Merge tracts with population data
# The first parameter (tracts_hispanic_population.shp) is the file we're creating
# The second parameter (tracts_within_cd27.shp) is the file we created in the previous command
# The sql query joins this shapefile with the csv with the Hispanic population info:
# hispanic_population.csv
# It does this by joining on the GEO id columns in each:
# tracts_within_cd27.GEOID = hispanic_population.GEOid2
ogr2ogr tracts_hispanic_population.shp tracts_within_cd27.shp -sql "select tracts_within_cd27.*, hispanic_population.* from tracts_within_cd27 left join 'hispanic_population.csv'.hispanic_population on tracts_within_cd27.GEOID = hispanic_population.GEOid2"

# After we created these files, let's move them to the edits directory
mv tracts_* ../edits
cd ../edits

# This is the command for: 3. Export
# The first parameter (-f GeoJSON) is the filetype we want to create
# In this case it's geojson
# The second parameter (tracts_hispanic_population.shp) is the file we're creating
# We're telling it to export this into the output directory
# The third parameter (tracts_hispanic_population.shp) is the file we're converting
ogr2ogr -f GeoJSON ../output/tracts_hispanic_population.geojson tracts_hispanic_population.shp