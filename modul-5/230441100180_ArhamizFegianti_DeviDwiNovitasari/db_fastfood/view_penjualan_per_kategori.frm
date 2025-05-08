TYPE=VIEW
query=select `km`.`nama_kategori_menu` AS `Kategori`,count(`t`.`id_transaksi`) AS `Jumlah Terjual`,sum(`t`.`total`) AS `Total Penjualan` from ((`db_fastfood`.`transaksi` `t` join `db_fastfood`.`produk` `p` on(`t`.`id_produk` = `p`.`id_produk`)) join `db_fastfood`.`kategori_menu` `km` on(`p`.`id_kategori_menu` = `km`.`id_kategori_menu`)) group by `km`.`nama_kategori_menu`
md5=7ca0ad480f4e321cb2e634215299d82a
updatable=0
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744643369856287
create-version=2
source=SELECT km.nama_kategori_menu AS \'Kategori\',\nCOUNT(t.id_transaksi) AS \'Jumlah Terjual\',\nSUM(t.total) AS \'Total Penjualan\'\nFROM transaksi t\nJOIN produk p ON t.id_produk = p.id_produk\nJOIN kategori_menu km ON p.id_kategori_menu = km.id_kategori_menu\nGROUP BY km.nama_kategori_menu
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `km`.`nama_kategori_menu` AS `Kategori`,count(`t`.`id_transaksi`) AS `Jumlah Terjual`,sum(`t`.`total`) AS `Total Penjualan` from ((`db_fastfood`.`transaksi` `t` join `db_fastfood`.`produk` `p` on(`t`.`id_produk` = `p`.`id_produk`)) join `db_fastfood`.`kategori_menu` `km` on(`p`.`id_kategori_menu` = `km`.`id_kategori_menu`)) group by `km`.`nama_kategori_menu`
mariadb-version=100432
