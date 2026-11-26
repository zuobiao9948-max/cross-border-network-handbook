Cross-Border Soft Router Hardware Selection & OpenWrt Checklist (跨境工作室软路由选型与防泄漏自查清单)

面向跨境电商店铺、TikTok 直播间与多手机矩阵工作室的 OpenWrt 软路由选型与上线自查参考。

完整图文深度对比与真实避坑解析见：跨境工作室软路由怎么选？N100 / R4S / J4125 实测对比（LGG CHINA）

1. 硬件选型速查表（按设备规模匹配）
工作室规模	推荐硬件	最低内存/网口建议	典型适用场景
1–5 台设备	友善 R4S / 二手 J4125	4G RAM / 双网口以上	个人跨境办公、少量账号养号
5–20 台设备	N100 四网口（主力推荐）	8G RAM / 4×2.5G 网口	多手机 TikTok 矩阵、1–2 个海外直播间
20 台以上设备	N100/N305 六网口工控机	16G RAM / 6 网口	大型跨境工作室、多宽带冗余、全屋分流隔离
2. OpenWrt 软路由上线前 4 项必查（防串号 / 防泄漏）

在正式把运营手机或直播机接入软路由前，务必完成以下 4 项核验：

彻底关闭或隔离本地 IPv6：防止国内光猫下发的本地 IPv6 绕过代理规则，导致真实地理位置暴露。
强制 DNS 劫持与远程解析：确保局域网内所有设备的 DNS 请求均通过目标出口解析，不出现“美国 IP + 国内运营商 DNS”。
按 MAC 地址绑定独立出口：在局域网静态 DHCP 分配中给每台运营手机固定内网 IP，再按内网 IP 路由到各自独立的海外静态住宅出口，杜绝多号串 IP。
SSH 快速排查命令（在 OpenWrt 终端执行）：
bash
# 查看当前路由器内核版本与 CPU 负载
uname -a && uptime
# 检查局域网内已连接设备的 MAC 与分配的内网 IP（用于策略分流绑定）
cat /tmp/dhcp.leases
# 验证软路由自身对外 DNS 解析是否正常
nslookup ipinfo.io
# 检查防火墙与路由表状态
ip route show
3. 在线检测与技术交付参考
IP 纯净度 / DNS 泄漏 / 测速一键检测台：LGG CHINA 控制台
软路由一对一部署交付说明（基础 ¥299 / 进阶 ¥599 / 企业 ¥799）：https://lggchina.com/services-2/
常用代理与网络运维文档：https://lggchina.com/lgg-network-guide/
配套电商短视频 AI 编导工作台：LGG CHINA AIGC 超级编导工作台
- 🛠️ [跨境工作室软路由选型与防泄漏自查清单（N100/R4S/J4125 + OpenWrt 排查命令）](./docs/soft-router-hardware-selection.md)
