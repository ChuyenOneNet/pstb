#!/bin/bash
set -e

LIBS_DIR="android/app/libs"
BACKUP_DIR="${LIBS_DIR}/backup_$(date +%Y%m%d_%H%M%S)"
TMP_DIR="./tmp_aar_clean"

echo "📦 Bắt đầu quét AAR trong thư mục: $LIBS_DIR"
echo "🗄️  Tạo thư mục backup tại: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Lặp qua toàn bộ file .aar
for aar in "$LIBS_DIR"/*.aar; do
  [ -e "$aar" ] || continue # bỏ qua nếu không có file .aar

  aar_name=$(basename "$aar")
  aar_tmp_dir="$TMP_DIR/$aar_name"

  echo "---------------------------------------------"
  echo "🔍 Đang xử lý: $aar_name"

  # Backup trước khi chỉnh sửa
  cp "$aar" "$BACKUP_DIR/$aar_name"

  # Giải nén
  rm -rf "$aar_tmp_dir"
  mkdir -p "$aar_tmp_dir"
  unzip -q "$aar" -d "$aar_tmp_dir"

  # Xóa ABI x86 / x86_64
  for abi in x86 x86_64; do
    if [ -d "$aar_tmp_dir/jni/$abi" ]; then
      echo "❌ Phát hiện thư mục jni/$abi — đang xóa..."
      rm -rf "$aar_tmp_dir/jni/$abi"
    fi
  done

  # Nén lại thành .aar mới (ghi đè bản cũ)
  echo "📦 Đang đóng gói lại $aar_name..."
  rm -f "$aar"
  (
    cd "$aar_tmp_dir"
    zip -qr "../../$aar" *
  )

  echo "✅ Đã làm sạch: $aar_name"
done

# Dọn thư mục tạm
rm -rf "$TMP_DIR"

echo "---------------------------------------------"
echo "🎉 Hoàn tất làm sạch tất cả AAR trong $LIBS_DIR!"
echo "📂 Bản gốc được lưu tại: $BACKUP_DIR"
