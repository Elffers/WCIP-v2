require 'rgeo-shapefile'

epsg_2926_proj4 = "+proj=lcc +lat_1=48.73333333333333 +lat_2=47.5 +lat_0=47 +lon_0=-120.8333333333333 +x_0=500000.0001016001 +y_0=0 +ellps=GRS80 +to_meter=0.3048006096012192 +no_defs"

nad83_wkt = <<WKT
PROJCS["NAD83(HARN) / Washington North (ftUS)",GEOGCS["NAD83(HARN)",DATUM["D_North_American_1983_HARN",SPHEROID["GRS_1980",6378137,298.257222101]],PRIMEM["Greenwich",0],UNIT["Degree",0.017453292519943295]],PROJECTION["Lambert_Conformal_Conic"],PARAMETER["standard_parallel_1",48.73333333333333],PARAMETER["standard_parallel_2",47.5],PARAMETER["latitude_of_origin",47],PARAMETER["central_meridian",-120.8333333333333],PARAMETER["false_easting",1640416.667],PARAMETER["false_northing",0],UNIT["Foot_US",0.30480060960121924]]
WKT

nad83_factory = RGeo::Cartesian.factory(:srid => 2926,
                                        :proj4 => epsg_2926_proj4,
                                        :coord_sys => nad83_wkt)

wgs84_proj4 = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'

wgs84_wkt = <<WKT
  GEOGCS["WGS 84",
    DATUM["WGS_1984",
      SPHEROID["WGS 84",6378137,298.257223563,
        AUTHORITY["EPSG","7030"]],
      AUTHORITY["EPSG","6326"]],
    PRIMEM["Greenwich",0,
      AUTHORITY["EPSG","8901"]],
    UNIT["degree",0.01745329251994328,
      AUTHORITY["EPSG","9122"]],
    AUTHORITY["EPSG","4326"]]
WKT

wgs84_factory = RGeo::Geographic.spherical_factory(:srid => 4326,
  :proj4 => wgs84_proj4, :coord_sys => wgs84_wkt)

RGeo::Shapefile::Reader.open('Street_Parking_by_Category_WebMercator.shp', :factory => wgs84_factory) do |file|
  file.each do |record|
    geom = record.geometry
    p geom.map { |s| s.points }
    p geom.map { |s|
      s.points.map { |point|
        RGeo::Feature.cast(point, :factory => nad83_factory, :project => true)
      }
    }
    break
  end
end
