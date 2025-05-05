TYPE=VIEW
query=select `a`.`nama_acara` AS `Nama Acara`,`b`.`nama_peserta` AS `Nama Peserta` from ((`eventorganize`.`acara` `a` join `eventorganize`.`detail_partisipan` `c` on(`a`.`id_acara` = `c`.`id_acara`)) join `eventorganize`.`partisipan` `b` on(`c`.`id_peserta` = `b`.`id_peserta`))
md5=fab7a255c0f328594e435e60f530593d
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001745682076077770
create-version=2
source=select \na.nama_acara as "Nama Acara",\nb.nama_peserta as "Nama Peserta"\nfrom acara a\njoin detail_partisipan c on a.id_acara=c.id_acara\njoin partisipan b on c.id_peserta =b.id_peserta
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`nama_acara` AS `Nama Acara`,`b`.`nama_peserta` AS `Nama Peserta` from ((`eventorganize`.`acara` `a` join `eventorganize`.`detail_partisipan` `c` on(`a`.`id_acara` = `c`.`id_acara`)) join `eventorganize`.`partisipan` `b` on(`c`.`id_peserta` = `b`.`id_peserta`))
mariadb-version=100432
