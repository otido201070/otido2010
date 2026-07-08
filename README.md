# V.E.R.I.T.A.S.

> **Variable Extraction & Reliable Inspection Tool for Android Systems**

**Truth Inside Every Device**

---

## About

VERITAS is a professional diagnostic toolkit for Android devices operating in **Fastboot Mode**.

Unlike traditional service utilities focused on flashing, unlocking or modifying devices, VERITAS is designed to safely extract, analyze and present the maximum amount of available information without changing the device state.

The project follows one fundamental rule:

> **Read Everything. Change Nothing.**

---

## Key Features

- Professional Fastboot diagnostics
- Automatic device identification
- OEM-specific information discovery
- Universal fallback scanner
- Security analysis
- Bootloader analysis
- Capability detection
- Device Health analysis
- Confidence-based data validation
- Human-readable console output
- Professional diagnostic reports
- Automatic log generation
- Modular architecture
- Safe update system
- SHA256 verification
- Windows 7–11 compatibility

---

## Safety

VERITAS never executes commands that intentionally modify the connected device.

The scanner is designed as a **read-only diagnostic system**.

Unknown OEM commands are ignored.

Potentially dangerous operations are excluded from automatic execution.

---

## Project Goals

- Maximum information
- Maximum safety
- Maximum compatibility
- Professional reporting
- Modular architecture
- Easy maintenance
- Long-term development

---

## Architecture

```
VERITAS
│
├── scanner.cmd
├── version.ini
├── repository.ini
│
├── Core
├── Database
├── OEM
├── PlatformTools
├── Reports
├── Logs
├── Temp
└── Backup
```

---

## Requirements

Windows 7 / 8 / 8.1 / 10 / 11

Android Platform Tools

Fastboot Mode

No installation required.

---

## Report

VERITAS creates two reports.

Console Summary

Compact information intended for service engineers.

Diagnostic Log

Complete diagnostic report containing every command, every response and every parsed value.

Logs are automatically stored inside:

```
Logs\
```

File name format:

```
<Model>_<IMEI>_<YYYY-MM-DD_HH-MM-SS>.log
```

If IMEI is unavailable:

```
<Model>_UnknownIMEI_<YYYY-MM-DD_HH-MM-SS>.log
```

---

## Update System

VERITAS supports secure updates.

Repository information is stored inside:

```
repository.ini
```

Every downloaded package is verified using SHA256 before installation.

Files are never replaced directly.

Update procedure:

```
Download

↓

SHA256 Verification

↓

Backup

↓

Replace

↓

Cleanup
```

---

## Compatibility

Designed for:

- Google
- Samsung
- Xiaomi
- Redmi
- POCO
- OnePlus
- OPPO
- Realme
- Vivo
- Honor
- Huawei
- Nothing
- Generic Android devices

Support is extended through modular OEM plugins.

---

## Philosophy

VERITAS is built around one simple idea:

> **Truth is more valuable than assumptions.**

Unknown values remain **Unknown**.

No fake detection.

No guessed information.

No unsafe actions.

---

## Author

OTiDO2010

Website

https://otido2010.narod.ru/

Telegram

https://tgrm.github.io/otido2010

---

## Project Status

Current Version

```
0.1.0 Alpha
```

Current Sprint

```
Sprint 1 — Foundation
```

---

## License

See:

```
LICENSE.txt
```

---

© 2026 OTiDO2010

VERITAS

Truth Inside Every Device