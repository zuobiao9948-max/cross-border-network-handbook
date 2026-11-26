# 3X-UI / S-UI / Sing-box Troubleshooting & Optimization Cheatsheet (自建节点排错与优化速查手册)
面向使用 **3X-UI、S-UI、Sing-box** 自建跨境网络节点的实用排错命令合集，覆盖连不上、晚高峰丢包、内存溢出断流与回程路由核验。
> 完整图文实战解析见：[3X-UI / S-UI / Sing-box 自建节点断流丢包排错手册（LGG CHINA）](https://lggchina.com/3x-ui-sing-box-node-troubleshooting-optimization-2026/)
---
## 1. 一键排错命令速查（Linux SSH 终端）
```bash
# 1. 检查系统时间（时间偏差 > 90 秒会导致 VLESS/VMess 握手失败）
timedatectl status
# 2. 开启并验证 TCP BBR 拥塞控制（改善跨洋高延迟与晚高峰抖动）
sysctl net.ipv4.tcp_congestion_control
# 若未开启，执行以下两行开启 BBR：
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
# 3. 检查端口监听与防火墙放行状态
ss -tulnp
ufw status
# 4. 排查小内存 VPS 是否发生 OOM（进程被系统杀掉导致突然断流）
dmesg -T | grep -i -E "oom|killed process" | tail -n 10
# 5. 检查三网回程路由（识别晚高峰绕路普通 163 线路）
curl -sL https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh | sh
```
---
## 2. 面板选型一句话参考
| 面板 / 核心 | 特点 | 推荐人群 |
| :--- | :--- | :--- |
| **3X-UI** | 界面成熟、社区资料最多、上手极快 | 新手快速搭建 VLESS / Reality 节点 |
| **S-UI** | 基于 Sing-box 内核，轻量且支持多协议 | 熟悉基础运维、偏好 Sing-box 生态的用户 |
| **原生 Sing-box** | 资源占用极低、规则引擎强大 | OpenWrt 软路由底层分流、多设备工作室环境 |
---
## 3. 配套脚本、文档与交付入口
- **常用面板脚本终端 & IP/测速工具台**：[LGG CHINA 控制台](https://lggchina.com/)
- **代理与跨境网络技术文档**：https://lggchina.com/lgg-network-guide/
- **客户端软件下载中心**：https://lggchina.com/software-center/
- **一对一技术交付套餐**（直连 ¥128 / 直播级环境 ¥268 / 软路由部署 ¥299–¥799）：https://lggchina.com/services-2/
- **配套跨境短视频 AI 编导工作台**：[LGG CHINA AIGC 超级编导工作台](https://ll.lggchina.com/)
