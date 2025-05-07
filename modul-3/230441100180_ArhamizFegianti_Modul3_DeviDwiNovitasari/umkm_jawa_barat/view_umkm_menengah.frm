TYPE=VIEW
query=select `s`.`nama_skala` AS `Skala Usaha`,`u`.`nama_usaha` AS `Nama Usaha`,`p`.`nama_lengkap` AS `Nama Pemilik`,`u`.`total_aset` AS `Total Aset UMKM`,`u`.`omzet_per_tahun` AS `Omset Per Tahun` from ((`umkm_jawa_barat`.`skala_umkm` `s` join `umkm_jawa_barat`.`umkm` `u` on(`u`.`id_skala` = `s`.`id_skala`)) join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) where `s`.`batas_aset_atas` = 10000000000
md5=7516d1dc42d7274abd583e6a451a2d2c
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744637385221666
create-version=2
source=SELECT \n    s.nama_skala AS \'Skala Usaha\',\n    u.nama_usaha AS \'Nama Usaha\',\n    p.nama_lengkap AS \'Nama Pemilik\',\n    u.total_aset AS \'Total Aset UMKM\',\n    u.omzet_per_tahun AS \'Omset Per Tahun\'\nFROM skala_umkm s\nJOIN umkm u ON u.id_skala = s.id_skala\nJOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik\nWHERE s.batas_aset_atas = 10000000000
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `s`.`nama_skala` AS `Skala Usaha`,`u`.`nama_usaha` AS `Nama Usaha`,`p`.`nama_lengkap` AS `Nama Pemilik`,`u`.`total_aset` AS `Total Aset UMKM`,`u`.`omzet_per_tahun` AS `Omset Per Tahun` from ((`umkm_jawa_barat`.`skala_umkm` `s` join `umkm_jawa_barat`.`umkm` `u` on(`u`.`id_skala` = `s`.`id_skala`)) join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) where `s`.`batas_aset_atas` = 10000000000
mariadb-version=100432
