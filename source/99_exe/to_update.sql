insert into system_menu (
menu_id, menu_group, menu_name, form_name, form_type, hide, dept_id, image_default) 
values ( '214','Item','Daftar Obat KF','frmObat',0,0,'capsul');

update mst_code set code_code = 'JS' where code_id = 36;
update mst_item set item_code = replace(item_code, 'M', 'S') where specification = 36;

insert into system_access(menu_id, access_list, user_id, can_acces) values(214, 0, 'owner', -1);
insert into system_access(menu_id, access_list, user_id, can_acces) values(214, 0, 'Welinda', -1);
insert into system_access(menu_id, access_list, user_id, can_acces) values(214, 0, 'Wina', -1);

update system_users set passwd = password('jax') where user_id = 'adm';