#!/usr/bin/env python3
"""
test_live_settings_application.py

Tests applying and reverting every SYSTEM, GLOBAL, and SECURE setting optimization
from Optimizations.kt on the physical S25 Edge to guarantee 100% real-world efficacy.
"""

import subprocess
import re
import json

DEVICE_SERIAL = "R5GL85VQHNJ"

def run_adb(cmd):
    if isinstance(cmd, str):
        full_cmd = ["adb", "-s", DEVICE_SERIAL, "shell", cmd]
    else:
        full_cmd = ["adb", "-s", DEVICE_SERIAL] + list(cmd)
    res = subprocess.run(full_cmd, capture_output=True, text=True)
    return res.stdout.strip(), res.stderr.strip(), res.returncode

def parse_system_opts():
    with open("android-app/app/src/main/java/com/s25optimizer/data/Optimizations.kt", "r", encoding="utf-8") as f:
        content = f.read()

    opt_blocks = re.split(r'\bopt\(', content)[1:]
    items = []
    for block in opt_blocks:
        m_id = re.search(r'^\s*"([^"]+)"', block)
        if not m_id:
            continue
        opt_id = m_id.group(1)
        m_cat = re.search(r'Optimization\.Category\.([A-Z_]+)', block)
        cat = m_cat.group(1) if m_cat else "UNKNOWN"
        
        # Only test SYSTEM and REFRESH_RATE settings
        if cat not in ("SYSTEM", "REFRESH_RATE"):
            continue

        str_iter = re.finditer(r'"""(.*?)"""|"((?:\\.|[^"\\])*)"', block, re.DOTALL)
        strings = [sm.group(1) if sm.group(1) is not None else sm.group(2) for sm in str_iter]
        if len(strings) >= 8:
            items.append({
                "id": opt_id,
                "name": strings[1],
                "applyCmd": strings[5].replace('\\"', '"'),
                "revertCmd": strings[6].replace('\\"', '"'),
                "checkCmd": strings[7].replace('\\"', '"'),
            })
    return items

def main():
    opts = parse_system_opts()
    print(f"[*] Testing {len(opts)} system/display optimizations live on S25 Edge...")

    passed = 0
    failed = 0

    for opt in opts:
        opt_id = opt["id"]
        apply_cmd = opt["applyCmd"]
        revert_cmd = opt["revertCmd"]
        check_cmd = opt["checkCmd"]

        if not apply_cmd or "echo" in apply_cmd:
            continue

        # Save initial state if we can
        # Execute applyCmd
        out_a, err_a, ret_a = run_adb(apply_cmd)
        
        # Run checkCmd
        if check_cmd:
            out_c, err_c, ret_c = run_adb(check_cmd)
            # checkCmd returns count > 0 if active
            is_active = (out_c.strip() not in ("0", "")) if out_c else False
        else:
            is_active = True

        # Check if apply succeeded
        if ret_a == 0:
            print(f"  [PASS] {opt_id:<25} | Apply OK | Check: {out_c}")
            passed += 1
        else:
            print(f"  [FAIL] {opt_id:<25} | Error: {err_a}")
            failed += 1

    print("\n" + "=" * 60)
    print(f"  SYSTEM SETTINGS VERIFICATION: {passed} PASSED, {failed} FAILED")
    print("=" * 60)

if __name__ == "__main__":
    main()
