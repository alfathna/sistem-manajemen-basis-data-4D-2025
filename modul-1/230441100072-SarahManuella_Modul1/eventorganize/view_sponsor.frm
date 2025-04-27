TYPE=VIEW
query=select `a`.`nama_acara` AS `Nama Acara`,`b`.`nama_org` AS `Penyelenggara`,`c`.`nama_sponsor` AS `Sponsorship`,`a`.`tanggal_acara` AS `Tanggal Acara` from ((`eventorganize`.`acara` `a` join `eventorganize`.`penyelenggara` `b` on(`a`.`id_org` = `b`.`id_org`)) join `eventorganize`.`sponsorship` `c` on(`a`.`id_acara` = `c`.`id_acara`))
md5=d53a71f04b8cade947578da77611a1fa
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744685990800846
create-version=2
source=SELECT\n    a.nama_acara AS "Nama Acara",\n    b.nama_org AS "Penyelenggara",\n    c.nama_sponsor AS "Sponsorship",  -- Pastikan kolom ini ada di tabel sponsorship\n    a.tanggal_acara AS "Tanggal Acara"\nFROM \n    acara a\nJOIN \n    penyelenggara b ON a.id_org = b.id_org\nJOIN \n    sponsorship c ON a.id_acara = c.id_acara
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `a`.`nama_acara` AS `Nama Acara`,`b`.`nama_org` AS `Penyelenggara`,`c`.`nama_sponsor` AS `Sponsorship`,`a`.`tanggal_acara` AS `Tanggal Acara` from ((`eventorganize`.`acara` `a` join `eventorganize`.`penyelenggara` `b` on(`a`.`id_org` = `b`.`id_org`)) join `eventorganize`.`sponsorship` `c` on(`a`.`id_acara` = `c`.`id_acara`))
mariadb-version=100432
