TYPE=VIEW
query=select `k`.`id_pegawai` AS `No Kasir`,`k`.`nama_pegawai` AS `Nama Kasir`,count(`t`.`id_transaksi`) AS `Jumlah Transaksi`,sum(`t`.`total`) AS `Total Penjualan`,avg(`t`.`total`) AS `Rata-rata Penjualan` from (`db_fastfood`.`kasir` `k` join `db_fastfood`.`transaksi` `t` on(`k`.`id_pegawai` = `t`.`id_pegawai`)) group by `k`.`id_pegawai`,`k`.`nama_pegawai`
md5=c28b432afa35aa4317456c706382f856
updatable=0
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744643191039019
create-version=2
source=SELECT k.id_pegawai as \'No Kasir\', k.nama_pegawai as \'Nama Kasir\',\nCOUNT(t.id_transaksi) AS \'Jumlah Transaksi\',\nSUM(t.total) AS \'Total Penjualan\',\nAVG(t.total) AS \'Rata-rata Penjualan\'\nFROM kasir k\nJOIN transaksi t ON k.id_pegawai = t.id_pegawai\nGROUP BY k.id_pegawai, k.nama_pegawai
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `k`.`id_pegawai` AS `No Kasir`,`k`.`nama_pegawai` AS `Nama Kasir`,count(`t`.`id_transaksi`) AS `Jumlah Transaksi`,sum(`t`.`total`) AS `Total Penjualan`,avg(`t`.`total`) AS `Rata-rata Penjualan` from (`db_fastfood`.`kasir` `k` join `db_fastfood`.`transaksi` `t` on(`k`.`id_pegawai` = `t`.`id_pegawai`)) group by `k`.`id_pegawai`,`k`.`nama_pegawai`
mariadb-version=100432
