TYPE=VIEW
query=select `a`.`nama_acara` AS `Nama Acara`,`a`.`lokasi` AS `Lokasi Acara`,`a`.`tanggal_acara` AS `Tanggal Pelaksanaan`,`b`.`nama_sponsor` AS `Sponsorship` from (`eventorganize`.`acara` `a` join `eventorganize`.`sponsorship` `b` on(`a`.`id_acara` = `b`.`id_acara`))
md5=1aaecc06a60fe1d9a778bf18d408c79c
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744951692188034
create-version=2
source=SELECT a.nama_acara as "Nama Acara",\na.lokasi as "Lokasi Acara",\na.tanggal_acara as "Tanggal Pelaksanaan",\nb.nama_sponsor as "Sponsorship"\n\nfrom acara a\njoin sponsorship b on a.id_acara = b.id_acara
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`nama_acara` AS `Nama Acara`,`a`.`lokasi` AS `Lokasi Acara`,`a`.`tanggal_acara` AS `Tanggal Pelaksanaan`,`b`.`nama_sponsor` AS `Sponsorship` from (`eventorganize`.`acara` `a` join `eventorganize`.`sponsorship` `b` on(`a`.`id_acara` = `b`.`id_acara`))
mariadb-version=100432
