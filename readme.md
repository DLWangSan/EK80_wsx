# EK80_wsx软件使用说明

[toc]

## 0. 软件信息

- 工具名称：EK80_wsx
- 版本：1.0
- 工具依赖
  - MATLAB Runtime
- 作者：王书献
- github地址：https://github.com/DLWangSan/EK80_wsx
- 邮箱：mr.wangshuxain@qq.com

## 1. 安装说明

> 本程序基于matlab，在没有安装matlab2016b的设备上使用本软件时， 需要安装**MCR(MATLAB Runtime)**。有关MCR的更多信息请参阅：[MCR](https://ww2.mathworks.cn/products/compiler/matlab-runtime.html))



### 1.1 MCR安装教程

- 从官网下载matlab2016b版本的MCR。若外网下载速度较慢，可以使用百度网盘，网盘链接为：

  ```
  链接：https://pan.baidu.com/s/17M3sy9EvXEGCZ1IQDmEddQ 
  提取码：8uw6
  ```

  

- 安装MCR

  - 右击以**管理员身份**运行MCR_R2016b_win64_installer.exe运行。安装过程较长，按照提示安装即可。

  - 除了安装路径可以改变之外，其他设置尽量保持默认。以免出现不必要的麻烦。

  - 安装完成后如图：

    ![MCR安装完成](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803194403805.png)

- 升级补丁文件

  - 在matlab官网中，有如下提示信息：

    > R2016a、R2016b 和 R2017a 版本的 MATLAB Runtime已有重要的安全补丁。在安装 其中一版MATLAB Runtime后，您应点击以下相应更新链接来更新到最近。请注意，这仅适用于您使用 MATLAB App Designer编写的 MATLAB 应用程序（.mlapp 文件）。更多信息，请参阅此 [Bug 报告](https://ww2.mathworks.cn/support/bugreports/1830810)。

  - 为了安全，在安装好MCR后，继续运行补丁文件。

    -  双击运行MCR_R2016b_Update_6.exe文件

    - 安装文件会自动定位到上一步安装的MCR路径，保持默认的设置，点击下一步。

    - 补丁安装完成后如图：

      ![补丁安装图](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803194442785.png)



### 1.2 EK80_wsx安装教程

- 双击运行**EK80_wsx_Setup.exe**文件

  - 若找不到该文件，可以从网盘下载：

    > 链接：https://pan.baidu.com/s/1ZTm1J2mmxPu691j0IgHecg 
    > 提取码：pxr9

  - 按照提示点击下一步安装，在软件协议处勾选同意，并点击下一步。

    ![协议](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803195014159.png)

  - 选择软件安装路径

    ![软件安装路径](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803195138154.png)

  - 安装完成

    ![安装完成](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803195256297.png)

- 安装完成后，桌面会创建软件快捷方式。菜单栏也会出现EK80_wsx快捷方式。

  ![快捷方式](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803195445583.png)

## 2. 使用教程

### 2.1 打开软件主界面

- 双击快捷方式，正常情况下会出现一个主界面，一个dos窗口。如遇异常，请检查MCR是否正确安装

  - 主界面

    ![主界面](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803195839850.png)

  - dos窗口

    ![DOS窗口](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803195927395.png)

- 在程序运行过程中，该两个窗口均会出现提示信息。主要区别：

  |  窗口   |                           作用                           |
  | :-----: | :------------------------------------------------------: |
  | 主窗口  |    显示软件操作按钮、运行过程中事件级别的实时日志数据    |
  | dos窗口 | 显示更底层的日志数据，对错误信息的描述更加清晰，便于调试 |

### 2.2 加载matlab引擎

- 点击主界面的**“加载matlab引擎”**按钮，等待程序加载完成，

- 加载完成后，主界面的日志区会有提示信息。

  ![加载引擎](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803200538752.png)

### 2.3 读取EK80文件

- 点击**“读取EK80文件”**按钮，选择需要读取的**RAW文件**

  ![选择RAW文件](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803200808921.png)

- 选择一个EK80的RAW数据文件，配置输出图的选项

  ![配置](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803200956753.png)

  - 配置说明

    | 参数                           | 说明                          | 参考值 |
    | ------------------------------ | ----------------------------- | ------ |
    | Range                          | 深度范围（m，越大耗时越久）   | 500    |
    | Range resolution               | 距离分辨力（m，越小耗时越久） | 1e-3   |
    | Minimum colour scale threshold | 最小显示分贝（dB）            | -70    |
    | Maximum colour scale threshold | 最大显示的分贝数（dB）        | -40    |

    

### 2.3 观察结果及保存

- 等待分析数据后，程序会生成两张图：

  - sp图

    ![sp](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803201649903.png)

  - sv图

    ![sv](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803201719824.png)

- 若需要保存图片，请按照以下步骤操作:
  1. 点击菜单栏中的**文件**
  2. 点击文件选项中的**保存**
  3. 在弹出的窗口中选择要保存的路径。
  4. 输入文件名
  5. 将保存类型修改为**.jpg**或其他常见的图片格式

- 本程序已经读取出RAW文件数据，以sp、sv图的形式展示出来。若需要对ek80的数据做进一步分析，请参阅**[二次开发说明]()**



## 3. 二次开发说明

> 本程序已经完成对EK80 RAW文件的读取。但仅仅只是以sp、sv图的形式展示结果。对EK80数据的挖掘、分析、展示都还有很大的扩展空间！此部分说明仅供二次开发者参考

### 3.2 原程序构造思路

1. 编写matlab脚本文件，以二进制数据流读取RAW文件；
2. 分别解析RAW数据的不同部分；
3. 提取信息，生成sp、sv图；
4. 将所有的matlab脚本生成一个python库（在我的CSDN中有教程）；
5. 在python环境中安装上一步中生成的库；
6. 在python中调用该程序；
7. 使用python编写程序界面；
8. 打包成安装文件

### 3.3 二开建议

- 在进行二次开发时，建议不修改底层的分析脚本。只修改对数据的提取和分析脚本。这是因为底层的读取已经完成，有很多读取出来的数据并没有被使用。
- 具体地，以下几个文件可以作为二次开发的主要目标。
  1. BasicProcessData.m
     - 读取数据后的处理，后文有详细分析
  2. CreateEchograms.m
     - 生成sp、sv图，在完善上一个文件之后，可以生成更多的数据图片。

### 3.4 读取数据分析

- 在运行脚本时，于BasicProcessData.m中加断点调试，观察ping数据

  ![断点调试](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803205146501.png)

- 观察pingData

  ![pingdata](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803205250777.png)

- 405个结构分别表示ek80的405次ping，每次的数据存储在SampleData中。

  - SampleData

    ![SampleData](C:\Users\13298\AppData\Roaming\Typora\typora-user-images\image-20200803205435607.png)

  - 数据结构较为复杂，二次开发者可以仿照这种方式观察数据、分析数据。

### 3.5 二次开发matlab脚本后，打包成python程序

- 完成matlab脚本的修改，保证在matlab中正常运行。
- 按照3.2中原程序构造方案，生成安装包。
  - matlab脚本生成python库的方法记录在我的CSDN中：[教程](https://blog.csdn.net/m0_38082373/article/details/107765149)

## 4. 常见错误

> 若发现其他错误，请邮件通知我（mr.wangshuxian@qq.com）。github端会继续更新本文档。

### 4.1 RuntimeError

提示信息为：

```bash
RuntimeError: Could not find an appropria
untime in PATH. Details: mclmcrrt9_1.dll
```

错误原因：MCR安装错误，按照教程重新安装MCR。