import os
import subprocess
import shutil
import time

def get_adb():
    if shutil.which("adb"):
        return "adb"
    local_sdk = os.path.expandvars(r"%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe")
    if os.path.exists(local_sdk):
        return local_sdk
    user_sdk = os.path.expanduser(r"~\AppData\Local\Android\Sdk\platform-tools\adb.exe")
    if os.path.exists(user_sdk):
        return user_sdk
    return "adb"

ADB_PATH = get_adb()

def get_first_device():
    try:
        res = subprocess.run([ADB_PATH, "devices"], capture_output=True, text=True, errors="replace", timeout=10)
        lines = res.stdout.strip().split("\n")[1:]
        for line in lines:
            parts = line.strip().split()
            if len(parts) >= 2 and parts[1] == "device":
                return parts[0]
    except Exception:
        pass
    return None

def adb_shell(cmd, device=None):
    try:
        base_cmd = [ADB_PATH]
        if device:
            base_cmd.extend(["-s", device])
        base_cmd.extend(["shell", cmd])
        res = subprocess.run(base_cmd, capture_output=True, text=True, errors="replace", timeout=60)
        return res.stdout.strip()
    except Exception as e:
        return f"Error: {e}"

def main():
    device = get_first_device()
    print("=== S25 EDGE DISK CLEANUP & RUNTIME MAINTENANCE ===")
    if device:
        print(f"Targeting device: {device}")

    # Check initial free space
    print("\n[1/7] Initial Storage Footprint:")
    print(adb_shell("df -h /data /storage/emulated/0", device))

    # Step 1: WhatsApp Sent Duplicates
    print("\n[2/7] Cleaning WhatsApp Sent duplicates...")
    wa_cmd = """
rm -rf "/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Video/Sent"/*
rm -rf "/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images/Sent"/*
touch "/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Video/Sent/.nomedia"
touch "/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images/Sent/.nomedia"
"""
    adb_shell(wa_cmd, device)
    print("WhatsApp Sent media folders cleaned.")

    # Step 2: Telegram & AyuGram Cache
    print("\n[3/7] Cleaning Telegram caches...")
    tg_cmd = """
rm -rf /sdcard/Android/data/org.telegram.messenger/cache/*
rm -rf /sdcard/Android/data/org.telegram.messenger/files/Telegram/*
rm -rf /sdcard/Android/data/com.radolyn.ayugram/cache/*
rm -rf /sdcard/Android/data/com.radolyn.ayugram/files/*
rm -rf "/sdcard/Download/AyuGram/Saved Attachments"/*
"""
    adb_shell(tg_cmd, device)
    print("Telegram caches cleared.")

    # Step 3: Gallery Thumbnails Cache
    print("\n[4/7] Cleaning Thumbnail caches...")
    thumb_cmd = """
rm -rf /sdcard/Pictures/.thumbnails/*
rm -rf /sdcard/DCIM/.thumbnails/*
"""
    adb_shell(thumb_cmd, device)
    print("Thumbnail caches cleared.")

    # Step 4: Obsolete APK Installers in Download
    print("\n[5/7] Cleaning obsolete APK installers...")
    apk_cmd = """
find /sdcard/Download -maxdepth 2 -name "*.apk" -delete
rm -f "/sdcard/Download/.pending-"*
"""
    adb_shell(apk_cmd, device)
    print("Obsolete APK installers cleaned.")

    # Step 5: Android Temp files and logs
    print("\n[6/7] Cleaning Android temp files and crash dumps...")
    temp_cmd = """
rm -f /sdcard/p.xml /sdcard/ui.xml /sdcard/u.xml
rm -f /data/local/tmp/app.apk
rm -f /data/local/tmp/*.dex
rm -f /data/local/tmp/*.json
rm -rf /data/log/*
"""
    adb_shell(temp_cmd, device)
    print("Temp logs and dex traces removed.")

    # Step 6: System cache trimming, fstrim, idle maint, bg-dexopt
    print("\n[7/7] Executing system-level maintenance & ART compilation...")
    adb_shell("pm trim-caches 999999999999", device)
    adb_shell("sm fstrim", device)
    adb_shell("sm idle-maint run", device)
    print("Executing background AOT dexopt job...")
    adb_shell("cmd package bg-dexopt-job", device)

    print("\n=== FINAL STORAGE FOOTPRINT ===")
    print(adb_shell("df -h /data /storage/emulated/0", device))
    print("\nCleanup and maintenance complete!")

if __name__ == "__main__":
    main()
