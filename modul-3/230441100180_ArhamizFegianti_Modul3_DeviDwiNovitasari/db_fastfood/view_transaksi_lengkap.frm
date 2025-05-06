TYPE=VIEW
query=select `c`.`nama_customer` AS `Nama Customer`,`k`.`nama_pegawai` AS `Kasir`,`t`.`tanggal` AS `Tanggal Transaksi`,`t`.`total` AS `Total Transaksi` from ((`db_fastfood`.`transaksi` `t` join `db_fastfood`.`customer` `c` on(`c`.`id_customer` = `t`.`id_customer`)) join `db_fastfood`.`kasir` `k` on(`k`.`id_pegawai` = `t`.`id_pegawai`))
md5=4a9309d6a103667c5e640ec1f9fc86f1
updatable=1
algorithm=0
definer_user=
definer_host=
suid=2
with_check_option=0
timestamp=0001744642454699601
create-version=2
source=select c.nama_customer as \'Nama Customer\', k.nama_pegawai as \'Kasir\',\nt.tanggal as \'Tanggal Transaksi\', t.total as \'Total Transaksi\'\nfrom transaksi t\njoin customer c on c.id_customer = t.id_customer\njoin kasir k on k.id_pegawai = t.id_pegawai
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `c`.`nama_customer` AS `Nama Customer`,`k`.`nama_pegawai` AS `Kasir`,`t`.`tanggal` AS `Tanggal Transaksi`,`t`.`total` AS `Total Transaksi` from ((`db_fastfood`.`transaksi` `t` join `db_fastfood`.`customer` `c` on(`c`.`id_customer` = `t`.`id_customer`)) join `db_fastfood`.`kasir` `k` on(`k`.`id_pegawai` = `t`.`id_pegawai`))
mariadb-version=100432
