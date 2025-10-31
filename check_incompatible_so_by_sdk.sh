#!/bin/bash
set -e

echo "🔍 Đang quét toàn bộ thư viện trong libs/ và build/..."
echo "----------------------------------------------------"

TMP_DIR="./tmp_aar_check"
OUTPUT_FILE="./so_report.txt"
rm -rf "$TMP_DIR" "$OUTPUT_FILE"
mkdir -p "$TMP_DIR"

# Danh sách CPU ABI hợp lệ mà Flutter hỗ trợ
SUPPORTED_ABI=("arm64-v8a" "armeabi-v7a" "x86_64")

# Hàm kiểm tra thư viện .so trong 1 AAR
check_aar() {
  local aar="$1"
  local aar_name
  aar_name=$(basename "$aar")

  unzip -o -q "$aar" -d "$TMP_DIR/$aar_name"
  so_files=$(find "$TMP_DIR/$aar_name" -type f -name "*.so" 2>/dev/null)

  for so in $so_files; do
    abi_dir=$(echo "$so" | grep -oE "jni/[^/]+" | cut -d'/' -f2)
    if [[ ! " ${SUPPORTED_ABI[*]} " =~ " ${abi_dir} " ]]; then
      echo "❌ $aar_name chứa .so không hợp lệ: $abi_dir/$(basename "$so")" >> "$OUTPUT_FILE"
    fi
  done

  rm -rf "$TMP_DIR/$aar_name"
}

# Quét tất cả AAR trong libs/
find ./android/app/libs -type f -name "*.aar" | while read -r aar; do
  check_aar "$aar"
done

# Quét các thư mục build (native libs hợp nhất)
find ./build -type f -name "*.so" | while read -r so; do
  abi_dir=$(echo "$so" | grep -oE "/lib/[^/]+" | cut -d'/' -f3)
  if [[ ! " ${SUPPORTED_ABI[*]} " =~ " ${abi_dir} " ]]; then
    echo "❌ build chứa .so không hợp lệ: $so" >> "$OUTPUT_FILE"
  fi
done

# Xuất kết quả
if [[ -s "$OUTPUT_FILE" ]]; then
  echo ""
  echo "📋 Danh sách .so không tương thích (16 KB issue):"
  echo "----------------------------------------------------"
  cat "$OUTPUT_FILE"
else
  echo "✅ Tất cả .so trong libs/ và build/ đều hợp lệ!"
fi

rm -rf "$TMP_DIR"
