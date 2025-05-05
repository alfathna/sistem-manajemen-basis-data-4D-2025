TYPE=VIEW
query=select `a`.`harga` AS `Harga Tiket`,`b`.`nama_acara` AS `Acara` from (`eventorganize`.`tiket` `a` join `eventorganize`.`acara` `b` on(`a`.`id_acara` = `b`.`id_acara`))
md5=7956b138d15286631e60261b6b94a6e1
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744684990422769
create-version=2
source=select \na.harga as "Harga Tiket",\nb.nama_acara as "Acara"\nfrom tiket a\njoin acara b on a.id_acara = b.id_acara
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`harga` AS `Harga Tiket`,`b`.`nama_acara` AS `Acara` from (`eventorganize`.`tiket` `a` join `eventorganize`.`acara` `b` on(`a`.`id_acara` = `b`.`id_acara`))
mariadb-version=100432
