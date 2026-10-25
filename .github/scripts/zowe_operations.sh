#!/bin/bash
# zowe_operations.sh

# Convert username to lowercase
LOWERCASE_USERNAME=$(echo "$ZOWE_USERNAME" | tr '[:upper:]' '[:lower:]')

# Check if directory exists, create if it doesn't
if ! zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" &>/dev/null; then
  echo "Directory does not exist. Creating it..."
  zowe zos-files create uss-directory "/z/$LOWERCASE_USERNAME/cobolcheck"
else
  echo "Directory already exists."
fi
#ls -R ./cobol-check
# Upload files
#SG zowe zos-files upload dir-to-uss "./cobol-check" "/z/$LOWERCASE_USERNAME/cobolcheck" --recursive --binary-files "cobol-check-0.2.9.jar"
# Upload files
SRC="./cobol-check/vs-code-extension/Cobol-check"
zowe zos-files upload dir-to-uss "$SRC" "/z/$LOWERCASE_USERNAME/cobolcheck" \
  --recursive \
  --binary-files "cobol-check-0.2.19.jar"
# Verify upload
echo "Verifying upload:"
zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck"
zowe zos-files upload file-to-uss "./NUMBERS.JCL" "/z/$LOWERCASE_USERNAME/cobolcheck/NUMBERS.JCL"
zowe zos-files upload file-to-data-set "./NUMBERS.JCL" "$ZOWE_USERNAME.JCL(NUMBERS)"
