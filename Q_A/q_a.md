常见问题 Q&A
=====


## 为什么`git clone`到本地后编译无法通过

工程使用git进行版本管理,为了让工程的体积不会随着更新疯狂增加,所以使用了子模块,关于子模块的内容可以自行搜索.

因此,执行`clone`命令后,需要执行`git submodule update --init`命令对子模块进行初始化和更新,否则SDK文件不全.
或者`clone`时使用`--recursive`参数,如果这种方式无法克隆,则使用上面先克隆再更新子模块的方式可以解决


## 为什么Windows下面和linux下面生成的lod文件大小不一样?

本工程生成的lod文件是字符文件,不是二进制文件,所以会比较大,
总所周知,字符文件在windows和linux下默认的换行符是不同的,
linux下使用的换行符是`LF(\n)`,windows下使用`CRLF(\r\n)`,
所以每多一个换行符,windows生成的lod文件就会比linux生成的会多一个字节,

因此,windows上生成的lod文件会比linux上的lod文件大一点,但是不会对程序有任何影响











