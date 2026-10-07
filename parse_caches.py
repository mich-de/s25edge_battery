import os
import subprocess
import shutil

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

def adb_shell(cmd):
    try:
        res = subprocess.run([ADB_PATH, "shell", cmd], capture_output=True, text=True, errors="replace", timeout=30)
        return res.stdout.strip()
    except Exception as e:
        return f"Error: {e}"

def main():
    print("=== S25 EDGE APP DATA CACHE AUDIT ===")
    output = adb_shell("du -d 2 -h /sdcard/Android/data 2>/dev/null | grep -E '/cache$' | sort -hr")
    lines = output.splitlines()
    print(f"Found {len(lines)} application cache directories:")
    for line in lines[:30]:
        print(f"  {line}")

if __name__ == "__main__":
    main()
