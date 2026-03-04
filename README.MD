# 🚀 RoboCopyPro: High-Performance Backup Tool

A professional-grade Windows batch script designed for speed, reliability, and automated record-keeping. Optimized for developers handling large project folders (like React, Node.js, and Python) and users transitioning to secure data management.

---

## 🛠️ Key Features

* **Multi-threaded Engine:** Uses **64 parallel threads** (`/MT:64`) to move thousands of small files in seconds.
* **Smart Logging:** Generates a unique, timestamped `.txt` log for every session.
* **Real-time Feedback:** Uses the `/TEE` flag to show progress on your screen while simultaneously writing to the log.
* **Auto-Cleanup:** Automatically deletes log files older than 30 days to prevent folder clutter.
* **Resume Support:** Includes a "Restartable" mode for large files (ISO, Databases, Video) that picks up where it left off after a crash.

---

## 📂 Operation Modes

| Option | Mode | Description | Risk Level |
| --- | --- | --- | --- |
| **1** | **Safe Copy** | Copies new/changed files only. **No deletions.** | ✅ Low |
| **2** | **Mirror** | Makes Destination an exact twin. **Deletes** extra files in Dest. | ⚠️ High |
| **3** | **Move** | Transfers files to Dest and **Deletes** them from Source. | ⚠️ High |
| **4** | **Dry Run** | Simulation only. Lists what *would* happen without moving data. | ✅ Zero |
| **5** | **Purge** | Deletes files in Dest that no longer exist in Source. | ⚠️ Med |
| **6** | **Resume** | Best for huge files over unstable connections. | ✅ Low |

---

## 📋 How to Use

1. **Launch:** Double-click `RoboCopyPro.bat`.
2. **Set Paths:** * **Source:** The folder you want to copy (e.g., `C:\Rushi\Projects`).
* **Destination:** Where you want the backup (e.g., `D:\Rushi\Backups`).


3. **Choose Mode:** Select a number from 1–6 based on your needs.
4. **Monitor:** Watch the screen or check the newly created `Backup_Log_YYYY-MM-DD.txt` file.

---

## 🔍 Understanding the Logs

The script generates logs with the format: `Backup_Log_YYYY-MM-DD_HH-MM.txt`.

* **Timestamps (`/TS`):** Every file entry shows exactly when it was processed.
* **Full Paths (`/FP`):** Lists the entire directory path for every file, making it easy to search (**Ctrl+F**).
* **Summary Table:** At the bottom of every log, Robocopy provides a table showing:
* **Total:** Files scanned.
* **Copied:** New or updated files moved.
* **Skipped:** Files already present and identical in the destination.
* **Mismatch/Failed:** Files that had errors (usually because they were in use).



---

## 💡 Pro Tips for Developers

* **Running as Admin:** If you are using **Option 6 (Resume)** or copying from `C:\Program Files`, right-click the `.bat` file and select **"Run as Administrator"**.
* **Testing Scripts:** If you are automating a new project backup, **always** run **Option 4 (Dry Run)** first to ensure your paths are correct.
* **The 30-Day Rule:** The script uses `forfiles` to delete logs older than 30 days. If you need to keep logs longer for legal or audit reasons, change the `/D -30` value in the script to a higher number.

---

## 🔧 Technical Summary (Flags)

* `/MT:64`: 64-way parallel processing.
* `/R:3 /W:5`: 3 retries, 5-second wait on locked files.
* `/LOG /TEE`: Combined file logging and console output.
* `/NP`: Progress percentages are hidden in the log to keep the text file clean.