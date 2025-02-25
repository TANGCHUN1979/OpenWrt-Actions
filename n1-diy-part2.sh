#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# Revert to official distfeeds
#sed -i '/ustclug/d' package/lean/default-settings/files/zzz-default-settings

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-argon-18.06）
#sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' ./feeds/luci/collections/luci/Makefile

# Modify some code adaptation
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Add autocore support for armvirt
#sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set DISTRIB_REVISION
#sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings

#Apply the patches
git apply $GITHUB_WORKSPACE/patches/*.patch

# Update mwan3helper's IP pools
#wget https://ispip.clang.cn/all_cn_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/all_cn.txt
#wget https://ispip.clang.cn/chinatelecom_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/chinatelecom.txt
#wget https://ispip.clang.cn/unicom_cnc_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/unicom_cnc.txt
#wget https://ispip.clang.cn/cmcc_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/cmcc.txt
#wget https://ispip.clang.cn/crtc_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/crtc.txt
#wget https://ispip.clang.cn/cernet_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/cernet.txt
#wget https://ispip.clang.cn/gwbn_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/gwbn.txt
#wget https://ispip.clang.cn/othernet_cidr.txt -O package/lean/luci-app-mwan3helper/root/etc/mwan3helper/othernet.txt

# Change dnsproxy behave
sed -i 's/--cache --cache-min-ttl=3600/--cache --cache-min-ttl=600/g' ./package/lean/luci-app-turboacc/root/etc/init.d/turboacc


# 1.Set the download repository of the OpenWrt files to your github.com
sed -i "s|https.*/OpenWrt|https://github.com/Gzxhwq/OpenWrt-Actions|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 2.Set the keywords of Tags in your github.com Releases
sed -i "s|ARMv8|Phicomm_N1|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 3.Set the suffix of the OPENWRT files in your github.com Releases
#sed -i "s|.img.gz|.OPENWRT_SUFFIX|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 4.Set the download path of the kernel in your github.com repository
sed -i "s|opt/kernel|https://github.com/breakings/OpenWrt/tree/main/opt/kernel|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 5.Set default filesystem in your github.com repository
sed -i "s|ext4|btrfs|g" package/others/luci-app-amlogic/root/etc/config/amlogic

