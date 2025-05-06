TYPE=VIEW
query=select `u`.`nama_usaha` AS `Nama Usaha`,`p`.`nama_lengkap` AS `Nama Pemilik`,`k`.`nama_kategori` AS `Kategori UMKM`,`s`.`nama_skala` AS `Skala Usaha`,`kb`.`nama_kabupaten_kota` AS `Nama Kabupaten/Kota`,`u`.`tahun_berdiri` AS `Tahun Berdiri` from ((((`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) join `umkm_jawa_barat`.`kategori_umkm` `k` on(`u`.`id_kategori` = `k`.`id_kategori`)) join `umkm_jawa_barat`.`skala_umkm` `s` on(`u`.`id_skala` = `s`.`id_skala`)) join `umkm_jawa_barat`.`kabupaten_kota` `kb` on(`u`.`id_kabupaten_kota` = `kb`.`id_kabupaten_kota`))
md5=2f756ede0a8a892e0a1c68a9b2c0acdc
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744630777895917
create-version=2
source=SELECT u.nama_usaha AS \'Nama Usaha\', p.nama_lengkap AS \'Nama Pemilik\',\nk.nama_kategori AS \'Kategori UMKM\', s.nama_skala AS \'Skala Usaha\',\nkb.nama_kabupaten_kota AS \'Nama Kabupaten/Kota\', u.tahun_berdiri AS \'Tahun Berdiri\'\nFROM umkm u\nJOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik\nJOIN kategori_umkm k ON u.id_kategori = k.id_kategori\nJOIN skala_umkm s ON u.id_skala = s.id_skala\nJOIN kabupaten_kota kb ON u.id_kabupaten_kota = kb.id_kabupaten_kota
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `u`.`nama_usaha` AS `Nama Usaha`,`p`.`nama_lengkap` AS `Nama Pemilik`,`k`.`nama_kategori` AS `Kategori UMKM`,`s`.`nama_skala` AS `Skala Usaha`,`kb`.`nama_kabupaten_kota` AS `Nama Kabupaten/Kota`,`u`.`tahun_berdiri` AS `Tahun Berdiri` from ((((`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) join `umkm_jawa_barat`.`kategori_umkm` `k` on(`u`.`id_kategori` = `k`.`id_kategori`)) join `umkm_jawa_barat`.`skala_umkm` `s` on(`u`.`id_skala` = `s`.`id_skala`)) join `umkm_jawa_barat`.`kabupaten_kota` `kb` on(`u`.`id_kabupaten_kota` = `kb`.`id_kabupaten_kota`))
mariadb-version=100432
