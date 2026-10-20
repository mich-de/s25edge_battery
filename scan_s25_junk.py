import os
import subprocess
import shutil
import sys

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

def adb_shell(cmd, device=None):
    try:
        base_cmd = [ADB_PATH]
        if device:
            base_cmd.extend(["-s", device])
        base_cmd.extend(["shell", cmd])
        res = subprocess.run(base_cmd, capture_output=True, text=True, errors="replace", timeout=30)
        return res.stdout.strip()
    except Exception as e:
        return f"Error: {e}"

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

def main():
    device = get_first_device()
    print(f"=== S25 EDGE STORAGE & JUNK SCANNER ===")
    if device:
        print(f"Connected Device ID: {device}")
    else:
        print("Warning: No active device detected via ADB. Running default inspection...")

    print("\n=== 1. STORAGE SUMMARY ===")
    print(adb_shell("df -h /data /storage/emulated/0", device))

    print("\n=== 2. THUMBNAILS & MEDIA CACHE IN /sdcard ===")
    thumb_cmd = """
for p in /sdcard/DCIM/.thumbnails /sdcard/Pictures/.thumbnails /sdcard/.thumbnails; do
    if [ -d "$p" ]; then
        du -sh "$p" 2>/dev/null
        ls -lh "$p" 2>/dev/null | head -n 10
    fi
done
find /sdcard/DCIM /sdcard/Pictures -name "*thumbdata*" -exec ls -lh {} + 2>/dev/null
"""
    print(adb_shell(thumb_cmd, device))

    print("\n=== 3. LARGE FILES (>50MB) IN /sdcard/Download ===")
    print(adb_shell("find /sdcard/Download -type f -size +50M -exec ls -lh {} + 2>/dev/null", device))

    print("\n=== 4. APK INSTALLERS IN /sdcard ===")
    print(adb_shell("find /sdcard/Download /sdcard -maxdepth 3 -name '*.apk' -exec ls -lh {} + 2>/dev/null", device))

    print("\n=== 5. WHATSAPP & TELEGRAM DUPLICATES / CACHES ===")
    wa_tg_cmd = """
for d in /sdcard/Android/media/com.whatsapp/WhatsApp/Media/.Statuses \
         /sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\\ Video/Sent \
         /sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\\ Images/Sent \
         /sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\\ Voice\\ Notes \
         /sdcard/Android/data/org.telegram.messenger/cache \
         /sdcard/Android/data/org.thunderdog.challegram/cache \
         /sdcard/Android/data/com.radolyn.ayugram/cache \
         /sdcard/Telegram; do
    if [ -e "$d" ]; then
        du -sh "$d" 2>/dev/null
    fi
done
"""
    print(adb_shell(wa_tg_cmd, device))

    print("\n=== 6. TOP APP CACHES IN /sdcard/Android/data ===")
    data_cache_cmd = """
du -d 2 -h /sdcard/Android/data 2>/dev/null | grep -E '/cache$' | sort -hr | head -n 25
"""
    print(adb_shell(data_cache_cmd, device))

if __name__ == "__main__":
    main()
