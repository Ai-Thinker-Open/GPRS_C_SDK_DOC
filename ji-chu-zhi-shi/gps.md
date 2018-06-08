基础知识：GNSS(GPS)
===


## GNSS

Global Navigation Satellite System(全球卫星导航系统)，是全球卫星导航系统的统称，大家常说的GPS只是其中的一种定位系统，如下：

* **GPS**: Global Positioning System，全球定位系统，由美国研制，全球覆盖率高达98%，共24颗卫星。全球最早研制并投入使用的定位系统
* **BDS**: 中国的北斗卫星导航系统（BeiDou Navigation Satellite System）
* **GLONASS**: 来自俄罗斯
* **Galileo**: 欧洲的伽利略系统（ satellite navigation system）
* **QZSS**: 日本组建的定位系统。
* **SBAS**: 除了卫星定位系统，还有SBAS（Satellite-Based Augmentation System），即星基增强系统，通过地球静止轨道（GEO）卫星搭载卫星导航增强信号转发器，可以向用户播发星历误差、卫星钟差、电离层延迟等多种修正信息，实现对于原有卫星导航系统定位精度的改进，从而成为各航天大国竞相发展的手段。目前，全球已经建立起了多个SBAS系统，如美国的WAAS（Wide Area Augmentation System）、俄罗斯的SDCM（System for Differential Corrections and Monitoring）、欧洲的EGNOS（European Geostationary Navigation Overlay Service）、日本的MSAS（Multi-functional Satellite Augmentation System）以及印度的GAGAN（GPS Aided Geo Augmented Navigation）


## 坐标系WGS84,CGCS2000

定位离不开的肯定是坐标系，GPS使用的坐标系是**WGS84**（World Geodetic System 1984）坐标系，除了WGS84之外，中国还有**CGCS2000**(国家大地坐标系)。

## 坐标偏移标准GCJ-02 BD-09

除了有多个坐标系外，还有坐标偏移标准，大众使用的地图上的坐标都不是原生的WGS84或CGCS2000坐标，都是对原始坐标加入随机偏移再加密后的坐标。
偏移标准主要有**GCJ-02**(国家测绘局02号标准)（火星坐标），还有**BD09**(百度坐标)。

**所以鉴于有多重坐标系以及坐标偏移标准，在使用位置信息是一定要十分注意，获取到的数据是什么坐标，按照自己的需求进行转换**

> 比如A9G模块输出的坐标是WGS84坐标，得到坐标后想显示到百度地图，则需要将WGS84坐标转换成BD09坐标，如果显示到高德地图则需要转换成火星坐标，否则地图上显示的位置可能会有非常大的误差！！！


