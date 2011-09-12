delete from spd_dev.museum;
delete from spd_dev.school;
delete from spd_dev.region;

insert into spd_dev.region(id, region_name) select ID, Region from spd_orig.region;
insert into spd_dev.museum(id, name, old_spd_id, region_id) select ID, MuseumName, ID, Region from spd_orig.museums;
insert into spd_dev.school(id, name, old_spd_id, region_id) select ID, SchoolName, ID, RegionID from spd_orig.edubasemain;
