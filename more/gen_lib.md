将SDK生成为一个库(lib文件)
=======


使用 `platform/tools/genlib/genlib.sh`脚本

```
cd platform/tools/genlib
chmod +x genlib.sh
#./genlib.sh clean
./genlib.sh debug  # ./genlib.sh release
```

生成成功后在`build/csdk/lib/`目录下会有`lib*.a`

