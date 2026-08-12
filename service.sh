#!/system/bin/sh
# 等待开机完成
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 5
done
sleep 15

MODDIR=${0%/*}
CONF="$MODDIR/packages.conf"
LOG="/data/local/tmp/miui_cleaner_boot.log"

if [ ! -f "$CONF" ]; then
  echo "配置文件缺失: $CONF" > $LOG
  exit 1
fi

echo "===== 开机清理 $(date) =====" > $LOG
while read -r pkg; do
  # 去掉前后空白，跳过空行和注释行
  pkg=$(echo "$pkg" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  [ -z "$pkg" ] && continue
  [ "${pkg#\#}" != "$pkg" ] && continue

  pm clear "$pkg" >> $LOG 2>&1
  if [ $? -eq 0 ]; then
    echo "成功: $pkg" >> $LOG
  else
    echo "失败: $pkg" >> $LOG
  fi
done < "$CONF"
echo "===== 结束 =====" >> $LOG