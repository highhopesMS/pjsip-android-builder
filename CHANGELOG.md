# Change Log

## Version 3.0.0 (2025-12-26)

### Major Changes
* **16KB Page Size Support**: Full support for Android 15+ 16KB page size requirement
  * NDK r28c with 16KB alignment enabled by default
  * Required for Google Play Store submissions targeting Android 15+ (November 2025 deadline)
  * Compatible with both 4KB and 16KB devices

* **Oboe Audio Backend**: Added Google's Oboe as the new default audio backend
  * Lower latency audio compared to OpenSL ES
  * Automatic device selection and workarounds for device-specific issues
  * Falls back to AAudio (API 27+) or OpenSL ES on older devices
  * Can be disabled to use legacy OpenSL ES if needed

### Updated Dependencies
* **NDK**: r21e → r28c (required for 16KB page size support)
* **PJSIP**: 2.12.1 → 2.14.1 (includes Oboe support)
* **OpenSSL**: 1.1.1k → 3.4.0 (modern security, improved performance)
* **Opus**: 1.3.1 → 1.5.2 (ML-based improvements, better packet loss handling)
* **OpenH264**: 2.1.0 → 2.6.0 (security fixes, performance improvements)
* **SWIG**: 4.0.2 → 4.3.0 (improved Java bindings)
* **Android Build Tools**: 30.0.3 → 35.0.0
* **Command Line Tools**: 8512546 → 11076708

### Configuration Changes
* **Target Android API**: 21 → 24 (required for Oboe)
* **New config options**:
  * `ENABLE_OBOE` - Enable/disable Oboe audio backend
  * `DOWNLOAD_OBOE` - Download Oboe prefab package
  * `ENABLE_16KB_PAGE_SIZE` - Enable 16KB page size support

### Notes
* Minimum Android API is now 24 (Android 7.0) for Oboe support
* To use legacy OpenSL ES audio, set `ENABLE_OBOE=0` in config.conf
* All native libraries are now 16KB page size aligned by default

## Version 2.7.0 (2022-11-22)

* Add patch to fix update_contact_header when need_outbound is false and only reg_contact_uri_params is not empty
* **Issues fixed**:
  * #54

## Version 2.6.0 (2022-11-22)

* Add patch to allow exporting of RtcpFb event data to pjsua2
* Add switch and setting to change the default PJSIP_TRANSPORT_IDLE_TIME
* **Issues fixed**:
  * #50
  * #51

## Version 2.5.0 (2022-11-03)

* Add switch to compile with debug symbols
* **Issues fixed**:
  * #49

## Version 2.4.1 (2022-07-29)

* Add switches to compile PJSIP with only specific support libraries

## Version 2.4.0 (2022-07-28)

* Bump default versions
  * NDK to `r21e`
  * PJSIP to `2.12.1`
  * Cmd Tools to `8512546`
* **Issues fixed**:
  * #48

## Version 2.3.0 (2021-05-19)

* Bump default versions
  * NDK to `r20b`
  * SWIG to `4.0.2`
  * PJSIP to `2.11`
  * OpenSSL to `1.1.1k`
  * OpenH264 to `2.1.0`
  * Opus to `1.3.1`
* Use bcg729 to enable `g729` codec
* **Issues fixed**:
  * #43
  * #44

## Version 2.2.0 (2020-03-30)

* Add flag to support IPv6
* **Issues fixed**:
  * #41

## Version 2.1.0 (2019-09-13)

* **Issues fixed**:
  * #31
  * #36
