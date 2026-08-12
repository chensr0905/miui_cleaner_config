#!/system/bin/sh
MODDIR=${0%/*}
CONF="$MODDIR/packages.conf"

if [ ! -f "$CONF" ]; then
  echo "❌ 配置文件不存在: $CONF"
  exit 1
fi

TOTAL=0
SUCCESS=0

while read -r pkg; do
  pkg=$(echo "$pkg" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  [ -z "$pkg" ] && continue
  [ "${pkg#\#}" != "$pkg" ] && continue

  TOTAL=$((TOTAL + 1))
  pm clear "$pkg" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    SUCCESS=$((SUCCESS + 1))
    echo "✅ $pkg"
  else
    echo "❌ $pkg"
  fi
done < "$CONF"

echo "──────────────"
echo "完成 ${SUCCESS}/${TOTAL}"