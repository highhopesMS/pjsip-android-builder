#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

cp rtcpfb.patch $PJPROJECT_BASE_FOLDER

pushd "$PJPROJECT_BASE_FOLDER"

# Apply patch for media.hpp
patch -l -p0 < rtcpfb.patch
rm rtcpfb.patch

# Apply media.cpp change using sed (avoids trailing whitespace issues in PJSIP source)
MEDIA_CPP_FILE="pjsip/src/pjsua2/media.cpp"
if ! grep -q "PJMEDIA_EVENT_RX_RTCP_FB" "$MEDIA_CPP_FILE"; then
  sed -i '/data\.audDevError\.status = ev\.data\.aud_dev_err\.status;/a\
    } else if (type == PJMEDIA_EVENT_RX_RTCP_FB) {\
        data.rtcpFb.fbType = ev.data.rx_rtcp_fb.cap.type;\
        data.rtcpFb.isParamLengthZero = ev.data.rx_rtcp_fb.cap.param.slen == 0;' "$MEDIA_CPP_FILE"
  echo "Applied media.cpp RTCP FB fix"
fi

popd
