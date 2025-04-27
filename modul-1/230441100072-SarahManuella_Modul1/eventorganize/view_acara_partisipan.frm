TYPE=VIEW
query=select `p`.`nama_peserta` AS `Nama Peserta`,`a`.`nama_acara` AS `Nama Acara`,`dp`.`tgl_registrasi` AS `Tanggal Registrasi`,`a`.`tanggal_acara` AS `Tanggal Acara` from ((`eventorganize`.`detail_partisipan` `dp` join `eventorganize`.`partisipan` `p` on(`dp`.`id_peserta` = `p`.`id_peserta`)) join `eventorganize`.`acara` `a` on(`dp`.`id_acara` = `a`.`id_acara`))
md5=12a492eb91487f422e0a8f28f35f8d74
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744952530895175
create-version=2
source=SELECT \n    p.nama_peserta AS "Nama Peserta",\n    a.nama_acara AS "Nama Acara",\n    dp.tgl_registrasi AS "Tanggal Registrasi",\n    a.tanggal_acara AS "Tanggal Acara"\nFROM \n    detail_partisipan dp\nJOIN \n    partisipan p ON dp.id_peserta = p.id_peserta\nJOIN \n    acara a ON dp.id_acara = a.id_acara
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `p`.`nama_peserta` AS `Nama Peserta`,`a`.`nama_acara` AS `Nama Acara`,`dp`.`tgl_registrasi` AS `Tanggal Registrasi`,`a`.`tanggal_acara` AS `Tanggal Acara` from ((`eventorganize`.`detail_partisipan` `dp` join `eventorganize`.`partisipan` `p` on(`dp`.`id_peserta` = `p`.`id_peserta`)) join `eventorganize`.`acara` `a` on(`dp`.`id_acara` = `a`.`id_acara`))
mariadb-version=100432
