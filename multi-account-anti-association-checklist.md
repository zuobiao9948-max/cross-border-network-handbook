# Cross-Border Multi-Account Anti-Association Checklist (跨境电商与海外社媒多账号防关联自查清单)
面向亚马逊/独立站店铺、TikTok 短视频矩阵、广告账户及海外 AI 账号的多账号防关联隔离指南与上线前自查清单。
> 完整对比与实操解析见：[跨境电商与海外社媒多账号怎么防关联（LGG CHINA）](https://lggchina.com/cross-border-multi-account-anti-association-guide-2026/)
---
## 1. 上线前 6 项防关联硬核自查表
| 检查项 | 合格标准 | 常用验证方式 |
| :--- | :--- | :--- |
| **1. 独立出口 IP** | 一号一独享静态 `ISP` / `Residential` IP，避免连号 C 段 | `ipinfo.io` / `scamalytics.com` |
| **2. IPv6 阻断** | 未泄露本地运营商 IPv6 地址 | `curl -6 https://ifconfig.co`（应无法连通） |
| **3. DNS 一致性** | DNS 解析国家/地区与出口 IP 归属地 100% 一致 | `whoer.net` / `browserleaks.com/dns` |
| **4. WebRTC 隔离** | 禁用或仅走代理通道，不暴露真实公网/内网 IP | `browserleaks.com/webrtc` |
| **5. 浏览器/设备指纹** | 电脑端使用独立指纹浏览器窗口；手机端一机一号、拔卡关定位、时区语言匹配 | `pixelscan.net` / `abrahamjuliot.github.io/creepjs` |
| **6. 资料与支付隔离** | 注册邮箱、接码手机号、收款卡与主体信息严格独立 | 内部台账隔离管理 |
---
## 2. 电脑端 vs 手机端架构速查
- **电脑端（店铺 / 广告户 / 支付 / AI 账号）**：`指纹浏览器（独立环境窗口） + 独享静态 ISP 代理`
- **手机端（TikTok 矩阵 / 直播间 / IG）**：`独立运营手机（零客户端） + OpenWrt 软路由按 MAC 地址绑定各自独立出口`
---
## 3. 常用工具与一站式入口
- **IP 纯净度 / DNS / 测速在线控制台**：[LGG CHINA（lggchina.com）](https://lggchina.com/)
- **海外多账号防关联与 AI 工具聚合**：https://rt.lggchina.com/
- **软路由多设备隔离与一对一部署交付**（¥128–¥799 透明报价）：https://lggchina.com/services-2/
- **跨境短视频批量脚本与分镜工作台**：[LGG CHINA AIGC 超级编导工作台](https://ll.lggchina.com/)
