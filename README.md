# totoroschool / 去他妈的龙猫校园

这个 repo 主要用于记录我对龙猫校园进行的各类工作，包括但不限于逆向工程、抓包和 GPS 模拟定位。

## 文件结构

/source（已删除） ---- 通过 apktool、dex2jar 与 jd-gui 逆向工程得到的结果。需要者可以自取。  
/statistic.md ---- 通过httpcanary抓取到的蒲公英统计数据原文。  
/types ---- 针对龙猫服务器抓包后解密得到的类型定义，解密方法请自行探索。

## 工程日志 / 已知发现

龙猫校园会访问以下 5 种服务器：

1. 高德地图 API。
2. [龙猫校园 APP 更新后端](http://news.xtotoro.com:50001/school/filter/version?type=1)。
3. [运动数据服务器](http://md.hulaq.com:8088/ydapi/CGTService.svc)。
4. [蒲公英](https://www.pgyer.com/)。
5. [极光](https://www.jpush.cn/)。

高德地图：一个域名。用于地图数据。与高德地图服务器的通信用的是 SSL/TLS。  
APP 更新服务器：一个域名。用于检查 / 安装更新。与此服务器通信用的是 HTTP 明文。  
运动数据服务器：一个和赞助公司共用的域名。用于提交每次运动数据。与此服务器的通信用的*应该*是 AES+RSA 双重加密。（这是我逆向工程 APP 得到的结果，分析可能不准确）  
蒲公英：一个域名。用于用户数据统计。提交的统计信息相当全面且恶心。与此服务器通信用的是 HTTP 明文。  
极光：一个域名。用于用户数据统计。目前暂未启用（抓包返回值为“401 Unauthorized”）。与该服务器的通信进行了多层加密，第一层是SSL。

---

## 数据分析  

### 蒲公英统计  
当你第一次以及此后每次打开龙猫校园，还没有进行任何操作时，龙猫校园就会向[蒲公英的后端](http://www.pgyer.com/apiv1/sdkstat/launch)以http明文发送你的统计数据。统计数据原文参见[statistic.md](https://github.com/lixiang810/tororoschool/blob/main/statistic.md)  
简单分析一下便可发现，龙猫校园向蒲公英以明文发送了如下统计信息：

* 手机总空间与剩余空间
* 系统语言
* 是否已越狱（应该是对苹果的），但也许也是 root 检测。我的设备已 root，这项的值为1。
* _api_key 龙猫校园向蒲公英申请的 apikey，用于验证身份。
* /sdcard 剩余空间，对大部分手机而言同手机总空间。
* 软件包名，也就是龙猫校园的 com.tororo.school。
* protrait，即手机屏幕自动旋转是否锁定。
* 手机电量。
* 设备ID，即IMEI。
* 设备名称。
* 龙猫校园版本号。
* 设备分辨率。
* 龙猫校园版本编码。
* 网络状况（是wifi还是手机流量）
* 总内存与剩余内存（RAM）
* 系统版本（如我的 Android 10 在此处的值为 10 ）
* app 名称（即“龙猫校园”）
* 系统类型（Android 为 2，猜测 iOS 为 1）
* 设备型号
* 蒲公英 sdk 版本
* 设备型号（是的有个重复项）
* agkey，龙猫校园向蒲公英申请的 agkey，用于验证身份。

进行这些收集，龙猫校园并未向用户作任何提示，在 app 和其隐私服务协议里也并未指出。我认为这是相当过分的。要么是开发组与公司法务沟通不畅，要么是公司压根没把这个收集当回事。尽管这是国内软件厂商司空见惯的事，但丝毫无法改变其未经许可就搜集用户信息的恶劣本质。  

### APP更新服务器


---

待更新
