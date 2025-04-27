TYPE=VIEW
query=select `a`.`nama_acara` AS `Nama Acara`,count(`dp`.`id_peserta`) AS `Jumlah Partisipan`,avg(`t`.`harga`) AS `Rata-rata Harga Tiket` from ((`eventorganize`.`acara` `a` left join `eventorganize`.`detail_partisipan` `dp` on(`a`.`id_acara` = `dp`.`id_acara`)) left join `eventorganize`.`tiket` `t` on(`a`.`id_acara` = `t`.`id_acara`)) group by `a`.`id_acara`,`a`.`nama_acara`
md5=48d43356621b2889320b3fde24df811f
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744686729001284
create-version=2
source=SELECT \na.nama_acara AS "Nama Acara",\nCOUNT(dp.id_peserta) AS "Jumlah Partisipan",\nAVG(t.harga) AS "Rata-rata Harga Tiket"\nFROM \nacara a\nLEFT JOIN \ndetail_partisipan dp ON a.id_acara = dp.id_acara\nLEFT JOIN \nTiket t ON a.id_acara = t.id_acara\nGROUP BY \na.id_acara, a.nama_acara
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`nama_acara` AS `Nama Acara`,count(`dp`.`id_peserta`) AS `Jumlah Partisipan`,avg(`t`.`harga`) AS `Rata-rata Harga Tiket` from ((`eventorganize`.`acara` `a` left join `eventorganize`.`detail_partisipan` `dp` on(`a`.`id_acara` = `dp`.`id_acara`)) left join `eventorganize`.`tiket` `t` on(`a`.`id_acara` = `t`.`id_acara`)) group by `a`.`id_acara`,`a`.`nama_acara`
mariadb-version=100432
