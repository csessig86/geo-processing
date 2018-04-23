# This is the file where all of our analysis takes place

# We'll first jump into our raw_data directory, where all of these files live
cd raw_data
ls

# 1. Getting census tracts within CD-27
# The first parameter (cd27.shp) is the Congressional District 27 shapefile
# The second parameter (tracts.shp) is the census tracts shapefile
# With the ST_Intersects query, we can find all the census tracts with Congressional District 27
ogr2ogr test_export.shp cd27.shp -dialect sqlite -sql "SELECT * FROM cd27, tracts WHERE ST_Intersects(cd27.geometry, tracts.geometry)" tracts.shp

# 2. Merge tracts with population data

# 3. Export