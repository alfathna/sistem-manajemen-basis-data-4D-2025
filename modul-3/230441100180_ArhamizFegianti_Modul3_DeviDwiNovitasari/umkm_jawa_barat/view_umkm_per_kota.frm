TYPE=VIEW
query=select `kk`.`nama_kabupaten_kota` AS `Kabupaten/Kota`,count(`u`.`id_umkm`) AS `Jumlah UMKM` from (`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`kabupaten_kota` `kk` on(`u`.`id_kabupaten_kota` = `kk`.`id_kabupaten_kota`)) group by `kk`.`nama_kabupaten_kota`
md5=dbe143328a1a6d12027a0c5a08809dfe
updatable=0
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744637929331216
create-version=2
source=select kk.nama_kabupaten_kota as \'Kabupaten/Kota\', \ncount(u.id_umkm) as \'Jumlah UMKM\'\nfrom umkm u\njoin kabupaten_kota kk on u.id_kabupaten_kota = kk.id_kabupaten_kota\ngroup by kk.nama_kabupaten_kota
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `kk`.`nama_kabupaten_kota` AS `Kabupaten/Kota`,count(`u`.`id_umkm`) AS `Jumlah UMKM` from (`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`kabupaten_kota` `kk` on(`u`.`id_kabupaten_kota` = `kk`.`id_kabupaten_kota`)) group by `kk`.`nama_kabupaten_kota`
mariadb-version=100432
