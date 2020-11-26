---
find 命令例子集合
---
 创建 by kevin
===

1.基本例子,查找当前目录下全部的.cpp文件的列表
``` bash
find . -name "*.cpp"
```

2.管道命令,注意命令后部的字符
``` bash
find . -name "*.cpp" -exec ls -al {} \;
```

3.查找的文件是近期150天内没有修改的
``` bash
find . -name "*.cpp" -ctime -150
```
