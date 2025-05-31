# user-respawn

A simple, menu-driven Windows batch script to restore user profile data from backups created by [`userdump`](https://github.com/SoCalIT/userdump). Designed for IT pros, techs, and field support needing fast profile recovery on Windows 11 systems.

> Built by [@SoCal_IT](https://github.com/SoCalIT) to complement `userdump.bat`.

---

## What It Does

`user-respawn.bat` restores a user profile from a backup folder stored under `User_files_backup`, using a clean menu interface so there's **no need to manually type usernames or machine names**.

It’s powered by `robocopy`, with permissions skipped to ensure compatibility with USB drives and non-NTFS targets.

---

## Features

-  Auto-detects users and machines inside `User_files_backup`
-  Compatible with USB, network shares, and mapped drives
-  Fully compatible from Windows XP through 11
-  Input-validated, beginner-safe UI with numbered menus
-  Uses `robocopy` with retry/resume for fast performance
-  No admin required (NTFS ACLs skipped)

---

## How to Use

1. Plug in the backup drive or connect to the network share
2. Double-click `user-respawn.bat`
3. Follow the prompts:
    - Enter the root path (e.g. `E:` or `\\NAS\Backups`)
    - Select user → Select device → Confirm restore target
4. Sit back — files are restored to `%USERPROFILE%` by default

---

## Requirements

Windows 11
- Backups must follow this structure:
  
User_files_backup
└── Username
└── PC-NAME
└── [Profile folders and files...]

---

## Permissions

This version of `user-respawn` uses `/COPY:DAT` to avoid NTFS permission issues, making it compatible with:
- FAT32 and exFAT USB drives
- Read-only network shares
- Non-admin user accounts

---

**Made by [@SoCal_IT](https://github.com/SoCalIT)**
