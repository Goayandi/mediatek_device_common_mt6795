# mt6795 platform boardconfig

# Use the non-open-source part, if present
-include vendor/mediatek/mt6795/BoardConfigVendor.mk

ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_BOARD_PLATFORM := mt6795
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_NO_FACTORYIMAGE := true

# display related
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
VSYNC_EVENT_PHASE_OFFSET_NS := -8000000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := -8000000
#PRESENT_TIME_OFFSET_FROM_VSYNC_NS := 0
MTK_HWC_SUPPORT := yes
MTK_HWC_VERSION := 1.4.0

BOARD_CONNECTIVITY_VENDOR := MediaTek
BOARD_USES_MTK_AUDIO := true

ifeq ($(MTK_AGPS_APP), yes)
   BOARD_AGPS_SUPL_LIBRARIES := true
else
   BOARD_AGPS_SUPL_LIBRARIES := false
endif

ifeq ($(MTK_GPS_SUPPORT), yes)
  BOARD_GPS_LIBRARIES := true
else
  BOARD_GPS_LIBRARIES := false
endif

ifeq ($(strip $(BOARD_CONNECTIVITY_VENDOR)), MediaTek)
BOARD_CONNECTIVITY_MODULE := MT6630 
BOARD_MEDIATEK_USES_GPS := true
endif

ifeq ($(MTK_WLAN_SUPPORT), yes)
BOARD_WLAN_DEVICE := MediaTek
WPA_SUPPLICANT_VERSION := VER_0_8_X_MTK
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P
ifneq ($(strip $(MTK_BSP_PACKAGE)),yes)
MTK_WIFI_CHINESE_SSID := yes
ifeq ($(MTK_EAP_SIM_AKA), yes)
CONFIG_RILD_MULTI_SIM := yes
endif
endif
ifeq ($(strip $(MTK_BSP_PACKAGE)),yes)
MTK_WIFI_GET_IMSI_FROM_PROPERTY := yes
endif
endif

# Add MTK compile options to wrap MTK's modifications on AOSP.
COMMON_GLOBAL_CFLAGS += -DMTK_AOSP_ENHANCEMENT
COMMON_GLOBAL_CPPFLAGS += -DMTK_AOSP_ENHANCEMENT

# ptgen
MTK_PTGEN_CHIP := $(shell echo $(TARGET_BOARD_PLATFORM) | tr '[a-z]' '[A-Z]')
include device/mediatek/build/build/tools/ptgen/$(MTK_PTGEN_CHIP)/ptgen.mk
# Vanzo:hanshengpeng on: Tue, 21 Apr 2015 10:46:37 +0800
# use odex in user build
ifeq ($(TARGET_BUILD_VARIANT),user)
WITH_DEXPREOPT := true
endif
# End of Vanzo:hanshengpeng
