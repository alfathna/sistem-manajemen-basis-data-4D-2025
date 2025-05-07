TYPE=VIEW
query=select `km`.`nama_kategori_menu` AS `Kategori Menu`,`p`.`nama_produk` AS `Nama Produk`,`p`.`harga` AS `Harga` from (`db_fastfood`.`produk` `p` join `db_fastfood`.`kategori_menu` `km` on(`km`.`id_kategori_menu` = `p`.`id_kategori_menu`))
md5=1c04fc8ff21dac0de48dd71d52adb63a
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744641886216076
create-version=2
source=select km.nama_kategori_menu as \'Kategori Menu\', p.nama_produk as \'Nama Produk\', \np.harga as \'Harga\'\nfrom produk p\njoin kategori_menu km on km.id_kategori_menu = p.id_kategori_menu
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `km`.`nama_kategori_menu` AS `Kategori Menu`,`p`.`nama_produk` AS `Nama Produk`,`p`.`harga` AS `Harga` from (`db_fastfood`.`produk` `p` join `db_fastfood`.`kategori_menu` `km` on(`km`.`id_kategori_menu` = `p`.`id_kategori_menu`))
mariadb-version=100432
