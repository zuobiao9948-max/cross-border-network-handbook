# Fixing Domestic IPv6 Leaks on Meta (Facebook / Instagram) & Cross-Border Platforms (国内 IPv6 泄漏导致 Meta 封号排查与根治手册)
用于排查并彻底阻断跨境运营中因 **国内运营商默认下发 IPv6** 导致的“IPv4 在海外、IPv6 在国内”双栈分裂风控（高频触发 Facebook 广告户、Instagram、TikTok、Gemini 异常封号）。
> 完整原理分析与多端实操图文见：[明明挂了美国静态 IP，为什么 Meta 还是秒封？国内 IPv6 泄漏排查与根治（LGG CHINA）](https://lggchina.com/china-ipv6-leak-meta-facebook-ban-fix-2026/)
---
## 1. 国内三大运营商 IPv6 前缀速查（看到即代表已泄漏）
在 `test-ipv6.com`、`browserleaks.com/ip` 或终端执行检测命令时，若返回以下前缀的公网 IPv6，说明本地网络正在向 Meta 等支持 IPv6 优先的平台暴露真实国内位置：
| 运营商 | 公网 IPv6 前缀 | 风险状态 |
| :--- | :--- | :--- |
| **中国电信 (China Telecom)** | `240e::/20` | ⚠️ 高危泄漏 |
| **中国联通 (China Unicom)** | `2408::/20` | ⚠️ 高危泄漏 |
| **中国移动 (China Mobile)** | `2409::/20` | ⚠️ 高危泄漏 |
| **中国广电 / 教育网** | `240a::` / `2001:da8::` | ⚠️ 高危泄漏 |
---
## 2. 终端 5 秒快速检测与关闭命令
```bash
# 1. 检测当前是否暴露公网 IPv6（输出空白或超时才算安全）
curl -6 -s --max-time 4 https://ifconfig.co || echo "✅ 未检测到 IPv6 出口（安全）"
# 2. macOS 终端关闭 Wi-Fi 的 IPv6（需管理员密码）
networksetup -setv6off "Wi-Fi"
# 3. Linux (Debian/Ubuntu) 临时禁用全局 IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
```
- **Windows**：`网络和共享中心 -> 更改适配器设置 -> 网卡属性 -> 取消勾选 Internet 协议版本 6 (TCP/IPv6)`。
- **手机端（iPhone / Android）与全屋工作室**：手机端难以独立阻断 Wi-Fi 下发的 IPv6，必须在 **OpenWrt 软路由 / 主路由器源头关闭 LAN 口 RA 与 DHCPv6 分配**，或在代理内核（Sing-box / OpenClash）中直接 `reject` 非预期 IPv6 流量。
---
## 3. 配套检测工具与软路由交付入口
- **IP 纯净度 / IPv6 / DNS 泄漏一键检测台**：[LGG CHINA（lggchina.com）](https://lggchina.com/)
- **全屋防泄漏软路由与直连一对一交付**（直连 ¥128 / 直播级 ¥268 / 软路由 ¥299–¥799）：https://lggchina.com/services-2/
- **跨境短视频 AI 脚本与广告素材分镜工作台**：[LGG CHINA AIGC 超级编导工作台](https://ll.lggchina.com/)
