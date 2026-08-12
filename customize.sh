#!/system/bin/sh
# 设置操作按钮文字
set_perm_recursive $MODPATH 0 0 0755 0644
echo "actionButtonLabel=🧹 清理应用数据" >> $MODPATH/module.prop

# 如果 packages.conf 不存在则创建默认列表（双重保险）
if [ ! -f "$MODPATH/packages.conf" ]; then
  cat > $MODPATH/packages.conf <<EOF
# 需要清理数据的应用包名（一行一个，#开头为注释）
com.android.htmlviewer
com.miui.daemon
com.miui.powerkeeper
com.xiaomi.joyose
EOF
fi