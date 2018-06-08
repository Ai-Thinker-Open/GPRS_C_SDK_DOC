Basic knowledgement: GPS
===


## GNSS

Global Navigation Satellite System, is the general name of the global satellite navigation system. The GPS, as widely said, is just one of the positioning systems. As follows:

**GPS**:Global Positioning System,sets up by the United States, the global coverage rate is as high as 98%, with a total of 24 satellites. The earliest developed and used positioning system in the world

**BDS**: Chinese BeiDou Navigation Satellite System
**GLONASS**: Build from Russian
**Galileo**: The European Galileo system  satellite navigation system
**QZSS**: Japan made it.

**SBAS**: In addition to the satellite positioning system, there are SBAS (Satellite-Based Augmentation System), star based enhancement system, and satellite navigation enhancement signal transponder through the geostationary orbit (GEO) satellite, which can broadcast ephemeris error, satellite clock error, ionospheric delay and so on. The improvement of positioning accuracy of satellite navigation system has become a means of competing development for all space powers. Currently, many SBAS systems have been established in the world, such as the WAAS of the United States (Wide Area Augmentation System), the SDCM of Russia (System for Differential Corrections and), the European Union, and Japan. Mentation System) and GAGAN in India (GPS Aided Geo Augmented Navigation).


## WGS84,CGCS2000 standard(coordinate system)

The position must not be separated from the coordinate system. The coordinate system used by GPS is **WGS84** (World Geodetic System 1984) coordinate system. Besides WGS84, China also has **CGCS2000** (national geodetic coordinate system).

## Coordinate deviation standard GCJ-02 BD-09

In addition to multiple coordinates, there is a coordinate deviation standard. The coordinates on the map used by the public are not native WGS84 or CGCS2000 coordinates, all of which are the coordinates after adding random migration to the original coordinates and then encrypt.

The migration standards are mainly **GCJ-02** (National Bureau of Surveying and mapping No. 02) (Mars coordinates), and **BD09** (Baidu coordinates).

**So in view of the multiple coordinate system and the coordinate deviation standard, it is necessary to pay much attention to the use of location information, what coordinates are obtained and converted in accordance with your own needs.**

> For example, the A9G module output coordinates are WGS84 coordinates, after getting the coordinates to display the Baidu map, the WGS84 coordinates need to be converted to BD09 coordinates, if the map is google map, Martian coordinate should be used, otherwise the location on the map may have a very large deviation!!!!


