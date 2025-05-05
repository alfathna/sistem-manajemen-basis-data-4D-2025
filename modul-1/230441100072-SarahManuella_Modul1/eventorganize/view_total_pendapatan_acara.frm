TYPE=VIEW
query=select `a`.`nama_acara` AS `Nama Acara`,sum(`t`.`harga`) AS `Total Pendapatan` from (`eventorganize`.`tiket` `t` join `eventorganize`.`acara` `a` on(`t`.`id_acara` = `a`.`id_acara`)) group by `a`.`id_acara`,`a`.`nama_acara`
md5=c96b8060ad9accf0d4bc710e85e4ba35
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744686651286370
create-version=2
source=SELECT \na.nama_acara AS "Nama Acara",\nSUM(t.harga) AS "Total Pendapatan"\nFROM \nTiket t\nJOIN \nacara a ON t.id_acara = a.id_acara\nGROUP BY \na.id_acara, a.nama_acara
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`nama_acara` AS `Nama Acara`,sum(`t`.`harga`) AS `Total Pendapatan` from (`eventorganize`.`tiket` `t` join `eventorganize`.`acara` `a` on(`t`.`id_acara` = `a`.`id_acara`)) group by `a`.`id_acara`,`a`.`nama_acara`
mariadb-version=100432
