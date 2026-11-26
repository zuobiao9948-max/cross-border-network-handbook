# Clean Network Checklist for ChatGPT, Claude & Gemini (海外 AI 工具防封号与防降智网络自查清单)
面向重度使用 **ChatGPT Plus、Claude Pro/Max、Gemini、Claude Code、Cursor** 的开发者与跨境团队，快速排查导致封号、地区不可用和“静默降智”的底层网络问题。
> 完整防封指南与方案对比见：[ChatGPT / Claude / Gemini 账号防封与干净网络环境指南（LGG CHINA）](https://lggchina.com/chatgpt-claude-gemini-clean-network-anti-ban-guide-2026/)
---
## 1. AI 账号防封 5 项硬性标准
| 检查项 | 合格标准 | 违规后果 |
| :--- | :--- | :--- |
| **出口 IP 纯净度** | 独享静态 `ISP` / `Residential` IP，欺诈分 `< 15` | 共享脏 IP 极易触发 ChatGPT 降智或 Claude 秒封 |
| **地区稳定性** | 长期固定单一支持国家（推荐美国/日本/英国），关闭自动切节点 | 频繁跨国登录直接触发风控封号 |
| **不支持地区拦截** | 严禁出口经由香港、澳门、俄罗斯等受限地区 | 直接报 `Unavailable in your region` |
| **IPv6 与 DNS 隔离** | 阻断本地 IPv6 泄漏，DNS 解析与出口国家一致 | 导致 Google / Gemini 归属地冲突 |
| **终端代理接管** | 命令行工具（Claude Code / API）需走 TUN 全局或软路由分流 | 仅开浏览器代理会导致终端接口超时或地区受限 |
---
## 2. 终端一键检测 AI 出口环境（macOS / Linux）
```bash
# 1. 查看当前终端真实出口 IP、国家与 ASN（确认非受限地区且为干净运营商）
curl -s https://ipinfo.io/json
# 2. 检查 OpenAI / Cloudflare Trace 识别到的当前地区代码（看 loc= 字段）
curl -s https://chat.openai.com/cdn-cgi/trace | grep -E "ip=|loc=|warp="
# 3. 检查 Anthropic / Claude Trace 识别到的当前地区代码（看 loc= 字段）
curl -s https://claude.ai/cdn-cgi/trace | grep -E "ip=|loc=|warp="
# 4. 检查本地是否泄漏 IPv6
curl -6 -s --max-time 3 https://ifconfig.co || echo "IPv6 已阻断（安全）"
```
---
## 3. 配套工具与技术交付入口
- **AI 环境检测 / IP 纯净度查询控制台**：[LGG CHINA（lggchina.com）](https://lggchina.com/)
- **海外 AI 模型价格与能力聚合对比**：https://rt.lggchina.com/
- **干净出海直连与全屋软路由分流交付**（直连 ¥128 / 软路由 ¥299–¥799）：https://lggchina.com/services-2/
- **跨境电商短视频 AI 编导工作台**：[LGG CHINA AIGC 超级编导工作台](https://ll.lggchina.com/)
