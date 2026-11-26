TikTok Live Streaming Network Checklist & Troubleshooting (TikTok 海外直播网络排错与部署清单)

本清单整理自跨境直播间一线排错经验，用于排查 TikTok / YouTube 海外带货直播 中常见的晚高峰卡顿、黑屏断流、画质压缩及开播 0 播放问题。

完整图文深度解析与方案对比见：TikTok 直播间掉线卡顿排查与部署实操（LGG CHINA）

1. 开播前 5 项硬指标体检表
检测项目	推荐工具	直播合格线	不合格时的典型症状
持续上行带宽 (Upload)	Cloudflare Speed / Speedtest	>= 10 Mbps（晚高峰实测）	画面糊成马赛克、码率骤降
抖动与丢包 (Jitter / Loss)	MTR / Ping	抖动 < 30ms，丢包 < 1%	直播转圈、间歇性断流黑屏
落地 IP 属性 (ASN / Type)	ipinfo.io	Type: ISP 或 Residential	开播 0 播放、刚起量被限流
欺诈风险分 (Fraud Score)	scamalytics.com	建议 < 15	频繁触发验证或直播间异常中断
DNS / WebRTC / 时区一致性	whoer.net / browserleaks.com	与目标国家城市 100% 一致	账号环境漂移、推荐流量跑偏

常用检测与测速工具聚合入口：LGG CHINA 在线控制台

2. Linux 中转机 / 落地机快速排错命令

如果你采用的是 “国内 -> 优化线路中转 VPS -> 纯净住宅落地” 架构，开播前建议在中转机与落地机分别跑一遍以下检查：

bash
# 1. 核验落地机真实出口 IP、ASN 与归属城市
curl -s https://ipinfo.io/json
# 2. 检查是否已开启 TCP BBR 拥塞控制（显著改善跨洋推流抖动）
sysctl net.ipv4.tcp_congestion_control
# 若未开启，确保输出包含 bbr
# 3. 测试三网回程路由（确认晚高峰未绕路普通 163 线路）
curl -sL https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh | sh
# 4. 持续 100 次丢包与抖动压测（替换 <TARGET_IP> 为你的落地机 IP）
mtr -r -c 100 <TARGET_IP>
3. 架构选型速查
单机试水 / 轻度直播：优化线路中转 + 独享静态 ISP 落地（避免直连无优化的美东家宽）。
多手机矩阵 / 日播 2 小时以上工作室：强烈建议采用 OpenWrt 软路由网关层分流，通过 MAC 地址绑定将每台直播手机固定到独立出口，手机端零客户端运行，避免发烫杀后台与 DNS 泄漏。

如需一对一远程交付（直连方案 ¥128 / 直播级环境部署 ¥268 / 软路由部署 ¥299–¥799），可参考：

服务与透明报价说明：https://lggchina.com/services-2/
技术文档与脚本终端：https://lggchina.com/lgg-network-guide/
配套短视频引流脚本工具：LGG CHINA AIGC 超级编导工作台
