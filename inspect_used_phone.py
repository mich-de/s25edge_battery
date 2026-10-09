import subprocess
import json
import os
import re

ADB_DEV = "R5GL85VQHNJ"

def run_adb(cmd):
    full_cmd = ["adb", "-s", ADB_DEV, "shell"] + cmd.split(" ")
    try:
        res = subprocess.run(full_cmd, capture_output=True, text=True, errors="replace", timeout=15)
        return res.stdout.strip()
    except Exception as e:
        return f"Error: {e}"

def run_adb_raw(cmd_str):
    full_cmd = ["adb", "-s", ADB_DEV, "shell", cmd_str]
    try:
        res = subprocess.run(full_cmd, capture_output=True, text=True, errors="replace", timeout=20)
        return res.stdout.strip()
    except Exception as e:
        return f"Error: {e}"

def main():
    print("=== STARTING FULL HARDWARE & SENSOR DIAGNOSTIC ===")
    
    # 1. Properties
    props_to_check = [
        "ro.product.model",
        "ro.product.brand",
        "ro.product.name",
        "ro.product.device",
        "ro.product.manufacturer",
        "ro.soc.model",
        "ro.board.platform",
        "ro.hardware",
        "ro.hardware.chipname",
        "ro.build.version.release",
        "ro.build.version.security_patch",
        "ro.build.version.oneui",
        "ro.build.display.id",
        "ro.boot.warranty_bit",
        "ro.boot.flash.locked",
        "ro.boot.verifiedbootstate",
        "ro.boot.serialno",
        "gsm.version.baseband",
        "ro.csc.sales_code",
        "ro.csc.country_code",
        "ril.official_cscver",
        "ro.crypto.state",
        "ro.crypto.type"
    ]
    props = {}
    for p in props_to_check:
        props[p] = run_adb(f"getprop {p}")
        
    # 2. Battery Subsystem
    battery_dumpsys = run_adb("dumpsys battery")
    
    # Try finding battery sysfs nodes
    sysfs_find = run_adb_raw("find /sys/class/power_supply -maxdepth 3 -type f 2>/dev/null")
    
    battery_sysfs = {}
    nodes_to_read = [
        "/sys/class/power_supply/battery/battery_cycle",
        "/sys/class/power_supply/battery/cycle_count",
        "/sys/class/power_supply/battery/fg_cycle",
        "/sys/class/power_supply/battery/fg_asoc",
        "/sys/class/power_supply/battery/fg_fullcapnom",
        "/sys/class/power_supply/battery/fg_capacity",
        "/sys/class/power_supply/battery/batt_capacity_max",
        "/sys/class/power_supply/battery/batt_full_capacity",
        "/sys/class/power_supply/battery/batt_health_check",
        "/sys/class/power_supply/battery/health",
        "/sys/class/power_supply/battery/capacity",
        "/sys/class/power_supply/battery/voltage_now",
        "/sys/class/power_supply/battery/current_now",
        "/sys/class/power_supply/battery/temp",
        "/sys/class/power_supply/battery/batt_temp",
        "/sys/class/power_supply/battery/batt_type",
        "/sys/class/power_supply/sec-battery/battery_cycle",
        "/sys/class/power_supply/sec-battery/cycle_count",
        "/sys/class/power_supply/sec-battery/fg_asoc",
        "/sys/class/power_supply/sec-battery/fg_fullcapnom",
        "/sys/class/power_supply/sec-battery/health",
        "/sys/class/power_supply/sec-battery/capacity",
        "/sys/class/power_supply/sec-battery/temp"
    ]
    for n in nodes_to_read:
        val = run_adb_raw(f"cat {n} 2>/dev/null")
        if val and not "No such file" in val and not "Permission denied" in val:
            battery_sysfs[n] = val

    # 3. Sensors
    sensors_raw = run_adb_raw("dumpsys sensorservice")
    
    # 4. Thermals
    thermals_dumpsys = run_adb_raw("dumpsys thermalservice")
    thermal_zones = run_adb_raw("for z in /sys/class/thermal/thermal_zone*; do [ -d \"$z\" ] && echo \"$(cat $z/type 2>/dev/null): $(cat $z/temp 2>/dev/null)\"; done | head -n 30")

    # 5. Storage & Partitions
    storage_df = run_adb_raw("df -h /data /system /metadata /storage/emulated/0")
    storage_blocks = run_adb_raw("ls -l /dev/block/bootdevice/by-name 2>/dev/null | head -n 20")
    
    # 6. Display
    display_info = run_adb_raw("dumpsys display | grep -E 'mBaseDisplayInfo|DisplayDeviceInfo|mCurrentDisplayMode|supportedModes|fps'")

    # 7. Camera
    camera_info = run_adb_raw("dumpsys media.camera | grep -E 'Camera ID|Facing|Resource Cost|Device Version'")

    # 8. Accounts & Locks
    accounts_info = run_adb_raw("dumpsys account | grep -E 'Account {'")
    provisioned = run_adb("settings get global device_provisioned")
    frp_check = run_adb_raw("ls -l /dev/block/by-name/frp /dev/block/bootdevice/by-name/persistent 2>/dev/null")

    # 9. RAM & CPU
    meminfo = run_adb_raw("dumpsys meminfo | head -n 30")

    output_data = {
        "properties": props,
        "battery_dumpsys": battery_dumpsys,
        "battery_sysfs": battery_sysfs,
        "sysfs_find": sysfs_find,
        "sensors_raw": sensors_raw[:4000],  # first 4k chars
        "thermals_dumpsys": thermals_dumpsys[:2000],
        "thermal_zones": thermal_zones,
        "storage_df": storage_df,
        "display_info": display_info,
        "camera_info": camera_info,
        "accounts_info": accounts_info,
        "device_provisioned": provisioned,
        "meminfo_head": meminfo
    }

    with open("diagnostic_raw.json", "w", encoding="utf-8") as f:
        json.dump(output_data, f, indent=2)

    print("Diagnostic collection complete! Saved to diagnostic_raw.json")

if __name__ == "__main__":
    main()
