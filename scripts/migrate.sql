delete from spd_dev.museum;
delete from spd_dev.school;
delete from spd_dev.region;
delete from spd_dev.visit;
delete from spd_dev.classifier;


insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (1,0,0,'keystage',NULL);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (2,0,1,'EarlyYears',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (3,0,1,'KS1',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (4,0,1,'KS2',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (5,0,1,'KS3',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (6,0,1,'KS4',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,parent_id) values (7,0,1,'Post16',1);

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

delete from spd_dev.visit_postings;

insert into spd_dev.visit_postings(visit_id,classifier_id) select id,2 from spd_orig.schoolsvisits where KSEarly = 1;
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,3 from spd_orig.schoolsvisits where KS1 = 1;
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,4 from spd_orig.schoolsvisits where KS2 = 1;
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,5 from spd_orig.schoolsvisits where KS3 = 1;
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,6 from spd_orig.schoolsvisits where KS4 = 1;
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,7 from spd_orig.schoolsvisits where Post16 = 1;
