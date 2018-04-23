#
cd raw_data

ogr2ogr $SHP_EDIT_1.shp $SHP.shp -sql "select $SHP.*, $FILE_EDIT_3.* from $SHP left join '$FILE_EDIT_3.csv'.$FILE_EDIT_3 on $SHP.CNTYVTD = $FILE_EDIT_3.cntyvtd"

mapshaper $SHP_EDIT_2.shp -simplify dp $SIMPLIFY -proj wgs84 -o format=topojson $TOPOJSON.topojson