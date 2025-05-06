TYPE=VIEW
query=select `p`.`nik` AS `NIK`,`p`.`nama_lengkap` AS `Nama Pemilik`,`p`.`jenis_kelamin` AS `Jenis Kelamin`,`p`.`nomor_telepon` AS `No Telepon`,`p`.`email` AS `Email`,`u`.`nama_usaha` AS `Nama Usaha` from (`umkm_jawa_barat`.`pemilik_umkm` `p` join `umkm_jawa_barat`.`umkm` `u` on(`u`.`id_pemilik` = `p`.`id_pemilik`))
md5=97a845a124a4ec33d9fab5ab6fbf26ec
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744631257523004
create-version=2
source=SELECT p.NIK AS \'NIK\', p.nama_lengkap AS \'Nama Pemilik\',\np.jenis_kelamin as \'Jenis Kelamin\', p.nomor_telepon as \'No Telepon\',\np.email as \'Email\', u.nama_usaha as \'Nama Usaha\'\nFROM pemilik_umkm p\njoin umkm u on u.id_pemilik = p.id_pemilik
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `p`.`nik` AS `NIK`,`p`.`nama_lengkap` AS `Nama Pemilik`,`p`.`jenis_kelamin` AS `Jenis Kelamin`,`p`.`nomor_telepon` AS `No Telepon`,`p`.`email` AS `Email`,`u`.`nama_usaha` AS `Nama Usaha` from (`umkm_jawa_barat`.`pemilik_umkm` `p` join `umkm_jawa_barat`.`umkm` `u` on(`u`.`id_pemilik` = `p`.`id_pemilik`))
mariadb-version=100432
