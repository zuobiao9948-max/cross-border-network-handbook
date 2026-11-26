#!/usr/bin/env bash
# ==============================================================================
# LGG CHINA - Cross-Border Network & AI Environment Quick Audit Script
# 跨境网络环境与海外 AI 解锁一键体检脚本 (只读检测，不修改任何系统配置)
# Repo: https://github.com/ (cross-border-network-handbook)
# Site: https://lggchina.com
# ==============================================================================

set -u

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}   LGG CHINA 跨境网络与 AI 环境一键体检 (lggchina.com)      ${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""

# 1. 公网 IPv4、ASN 与归属地检测
echo -e "${YELLOW}[1/5] 正在检测公网 IPv4、ASN 与归属地...${NC}"
IP_JSON=$(curl -4 -s --max-time 6 https://ipinfo.io/json 2>/dev/null || true)
if [ -n "$IP_JSON" ]; then
  IP=$(echo "$IP_JSON" | grep '"ip"' | head -n1 | cut -d'"' -f4)
  ORG=$(echo "$IP_JSON" | grep '"org"' | head -n1 | cut -d'"' -f4)
  CITY=$(echo "$IP_JSON" | grep '"city"' | head -n1 | cut -d'"' -f4)
  REGION=$(echo "$IP_JSON" | grep '"region"' | head -n1 | cut -d'"' -f4)
  COUNTRY=$(echo "$IP_JSON" | grep '"country"' | head -n1 | cut -d'"' -f4)
  echo -e "  出口 IPv4 : ${GREEN}${IP:-未知}${NC}"
  echo -e "  运营商/ASN: ${GREEN}${ORG:-未知}${NC}"
  echo -e "  归属地区  : ${GREEN}${CITY:-未知}, ${REGION:-未知}, ${COUNTRY:-未知}${NC}"
else
  echo -e "  ${RED}获取 ipinfo.io 失败，请检查网络连接或代理配置。${NC}"
fi
echo ""

# 2. IPv6 泄漏检测
echo -e "${YELLOW}[2/5] 正在检测是否存在本地 IPv6 泄漏...${NC}"
IPV6=$(curl -6 -s --max-time 4 https://ifconfig.co 2>/dev/null || true)
if [ -n "$IPV6" ]; then
  echo -e "  ${RED}⚠️  检测到公网 IPv6 出口: $IPV6${NC}"
  echo -e "  提示：如用于 TikTok / 跨境店铺防关联，请确认该 IPv6 与目标国家一致，否则建议关闭本地 IPv6。"
else
  echo -e "  ${GREEN}✅ 未检测到 IPv6 出口（IPv6 已阻断或未启用，无本地泄漏风险）${NC}"
fi
echo ""

# 3. ChatGPT / Claude 地区识别检测 (Cloudflare Trace)
echo -e "${YELLOW}[3/5] 正在检测海外 AI 平台识别地区 (OpenAI / Claude)...${NC}"
OPENAI_LOC=$(curl -s --max-time 5 https://chat.openai.com/cdn-cgi/trace 2>/dev/null | grep '^loc=' | cut -d'=' -f2 || true)
CLAUDE_LOC=$(curl -s --max-time 5 https://claude.ai/cdn-cgi/trace 2>/dev/null | grep '^loc=' | cut -d'=' -f2 || true)
echo -e "  OpenAI / ChatGPT 识别地区: ${GREEN}${OPENAI_LOC:-无法连接}${NC}"
echo -e "  Anthropic / Claude 识别地区: ${GREEN}${CLAUDE_LOC:-无法连接}${NC}"
if [ "$OPENAI_LOC" = "HK" ] || [ "$OPENAI_LOC" = "CN" ] || [ "$CLAUDE_LOC" = "HK" ] || [ "$CLAUDE_LOC" = "CN" ]; then
  echo -e "  ${RED}⚠️  警告：当前识别地区为受限区域 ($OPENAI_LOC/$CLAUDE_LOC)，极易触发地区不可用或封号！${NC}"
fi
echo ""

# 4. 系统时间与 TCP BBR 检测 (仅 Linux)
echo -e "${YELLOW}[4/5] 正在检测系统时间与 TCP BBR 状态...${NC}"
echo -e "  当前系统时间: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
if [ "$(uname -s)" = "Linux" ]; then
  BBR=$(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null || echo "未知")
  if [ "$BBR" = "bbr" ]; then
    echo -e "  TCP 拥塞控制: ${GREEN}bbr (已开启，跨洋传输更稳)${NC}"
  else
    echo -e "  TCP 拥塞控制: ${YELLOW}${BBR} (建议开启 BBR 以降低晚高峰丢包抖动)${NC}"
  fi
else
  echo -e "  运行环境: $(uname -s) (跳过 Linux BBR 检测)"
fi
echo ""

# 5. 总结与进阶参考
echo -e "${YELLOW}[5/5] 进阶检测建议${NC}"
echo "  - 欺诈风险分查询 : https://scamalytics.com/"
echo "  - DNS/WebRTC 泄漏: https://whoer.net/ 或 https://browserleaks.com/"
echo "  - 一站式检测台   : https://lggchina.com/"
echo "  - 软路由与直播交付: https://lggchina.com/services-2/"
echo -e "${CYAN}============================================================${NC}"
