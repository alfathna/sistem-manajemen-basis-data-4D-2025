TYPE=VIEW
query=select `c`.`nama_customer` AS `Nama Customer`,`p`.`nama_produk` AS `Nama Produk`,`p`.`harga` AS `Harga Produk`,`t`.`total` AS `Total Transaksi` from ((`db_fastfood`.`transaksi` `t` join `db_fastfood`.`customer` `c` on(`c`.`id_customer` = `t`.`id_customer`)) join `db_fastfood`.`produk` `p` on(`p`.`id_produk` = `t`.`id_produk`)) where `t`.`total` <> 0
md5=830b135e296e07a25425b18b7c1fa2aa
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001746081006494018
create-version=2
source=SELECT c.nama_customer AS \'Nama Customer\', p.nama_produk AS \'Nama Produk\',\np.harga AS \'Harga Produk\', t.total AS \'Total Transaksi\'\nFROM transaksi t\nJOIN customer c ON c.id_customer = t.id_customer\nJOIN produk p ON p.id_produk = t.id_produk\nWHERE t.total
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `c`.`nama_customer` AS `Nama Customer`,`p`.`nama_produk` AS `Nama Produk`,`p`.`harga` AS `Harga Produk`,`t`.`total` AS `Total Transaksi` from ((`db_fastfood`.`transaksi` `t` join `db_fastfood`.`customer` `c` on(`c`.`id_customer` = `t`.`id_customer`)) join `db_fastfood`.`produk` `p` on(`p`.`id_produk` = `t`.`id_produk`)) where `t`.`total` <> 0
mariadb-version=100432
