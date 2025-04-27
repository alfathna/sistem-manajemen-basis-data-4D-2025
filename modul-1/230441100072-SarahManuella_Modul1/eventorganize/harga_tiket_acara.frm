TYPE=VIEW
query=select `a`.`harga` AS `Harga Tiket`,`b`.`nama_acara` AS `Nama Acara`,`a`.`tipe_tiket` AS `Tipe Tiket` from (`eventorganize`.`tiket` `a` join `eventorganize`.`acara` `b` on(`a`.`id_acara` = `b`.`id_acara`)) where `a`.`tipe_tiket` = \'VIP\'
md5=fcdb7a2f7dc98a2c297119c420953dd6
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744686439417078
create-version=2
source=SELECT \na.harga AS "Harga Tiket",\nb.nama_acara AS "Nama Acara",\na.tipe_tiket AS "Tipe Tiket"\nFROM \nTiket a\nJOIN \nacara b ON a.id_acara = b.id_acara\nWHERE \na.tipe_tiket = \'VIP\'
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`harga` AS `Harga Tiket`,`b`.`nama_acara` AS `Nama Acara`,`a`.`tipe_tiket` AS `Tipe Tiket` from (`eventorganize`.`tiket` `a` join `eventorganize`.`acara` `b` on(`a`.`id_acara` = `b`.`id_acara`)) where `a`.`tipe_tiket` = \'VIP\'
mariadb-version=100432
