TYPE=VIEW
query=select `u`.`nama_usaha` AS `Nama Usaha`,`pr`.`nama_produk` AS `Nama Produk`,`pr`.`deskripsi_produk` AS `Deskripsi Produk`,`pr`.`harga` AS `Harga` from (`umkm_jawa_barat`.`produk_umkm` `pr` join `umkm_jawa_barat`.`umkm` `u` on(`u`.`id_umkm` = `pr`.`id_umkm`))
md5=d4282c553e385dfda442382ec35b5c8c
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744636406860506
create-version=2
source=SELECT u.nama_usaha AS \'Nama Usaha\', pr.nama_produk AS \'Nama Produk\',\npr.deskripsi_produk AS \'Deskripsi Produk\', pr.harga AS \'Harga\'\nFROM produk_umkm pr\nJOIN umkm u ON u.id_umkm = pr.id_umkm
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `u`.`nama_usaha` AS `Nama Usaha`,`pr`.`nama_produk` AS `Nama Produk`,`pr`.`deskripsi_produk` AS `Deskripsi Produk`,`pr`.`harga` AS `Harga` from (`umkm_jawa_barat`.`produk_umkm` `pr` join `umkm_jawa_barat`.`umkm` `u` on(`u`.`id_umkm` = `pr`.`id_umkm`))
mariadb-version=100432
