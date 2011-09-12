delete from spd_dev.museum;
delete from spd_dev.school;
delete from spd_dev.region;
delete from spd_dev.visit;

insert into spd_dev.region(id, region_name) select ID, Region from spd_orig.region;
insert into spd_dev.museum(id, name, old_spd_id, region_id) select ID, MuseumName, ID, Region from spd_orig.museums;
insert into spd_dev.school(id, name, old_spd_id, region_id) select ID, SchoolName, ID, RegionID from spd_orig.edubasemain;
insert into spd_dev.visit(id, museum_id, school_id, party_size,visit_date) 
select ID, 
       MuseumID, 
       SchoolID, 
       PartySize, 
       STR_TO_DATE(VisitDate,'%d/%m/%Y')
from spd_orig.schoolsvisits;
