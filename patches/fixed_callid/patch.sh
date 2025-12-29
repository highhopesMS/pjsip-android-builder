#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

if [ "${IS_PJSIP_LOWER_THAN_2_11}" == "1" ]
then
  cp callid.old.patch $PJPROJECT_BASE_FOLDER/callid.patch
else
  cp callid.patch $PJPROJECT_BASE_FOLDER
fi

CURDIR=$(pwd)
cd "$PJPROJECT_BASE_FOLDER"

# Apply patch
patch -l -p0 < callid.patch
rm callid.patch

# Apply pjsua_acc.c regc_init change using sed (avoids trailing whitespace issues in PJSIP source)
# Note: Must only match pjsip_regc_init call, NOT pjsip_regc_update_expires call
# Use &acc->reg_contact as unique context - only present in regc_init call
PJSUA_ACC_FILE="pjsip/src/pjsua-lib/pjsua_acc.c"
if grep -q "&acc->reg_contact," "$PJSUA_ACC_FILE" && grep -q "acc->cfg.reg_timeout);" "$PJSUA_ACC_FILE"; then
  sed -i '/&acc->reg_contact,/{n; s/acc->cfg\.reg_timeout);/acc->cfg.reg_timeout,\n                              \&acc->cfg.call_id);/}' "$PJSUA_ACC_FILE"
  echo "Applied pjsua_acc.c regc_init fix"
fi

cd "$CURDIR"
