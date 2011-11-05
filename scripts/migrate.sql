delete from spd_dev.museum;
delete from spd_dev.school;
delete from spd_dev.region;
delete from spd_dev.visit;
delete from spd_dev.classifier;


insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  1,0,0,'keystage','Keystage',NULL);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  2,0,1,'EarlyYears','Early Years',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  3,0,1,'KS1','Keystage 1',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  4,0,1,'KS2','Keystage 2',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  5,0,1,'KS3','Keystage 3',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  6,0,1,'KS4','Keystage 4',1);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  7,0,1,'Post16','Post 16',1);


insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  8,0,0,'schoolyear','School Year',NULL);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values (  9,0,1,'N/A','N/A',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 10,0,1,'Pre5','Under 5',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 11,0,1,'Rec','Reception',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 12,0,1,'Y1','Year 1',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 13,0,1,'Y2','Year 2',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 14,0,1,'Y3','Year 3',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 15,0,1,'Y4','Year 4',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 16,0,1,'Y5','Year 5',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 17,0,1,'Y6','Year 6',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 18,0,1,'Y7','Year 7',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 19,0,1,'Y8','Year 8',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 20,0,1,'Y9','Year 9',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 21,0,1,'Y10','Year 10',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 22,0,1,'Y11','Year 11',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 23,0,1,'Y12','Year 12',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 24,0,1,'Y13','Year 13',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 25,0,1,'HE','HE - England',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 26,0,1,'Teach','Teachers',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 27,0,1,'Pre5-Y11-W/S/NI','Pre-5 to Year 11 Wales, Scotland or Northern Ireland',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 28,0,1,'Y12-Y13-W/S/NI','Year 12 to Year 13 Wales, Scotland or Northern Ireland',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 29,0,1,'Pre5-Y11-OS','Pre-5 to Year11 Overseas',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 30,0,1,'Y12-Y13-OS','Year 12 - Year 13 Overseas',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 31,0,1,'HE-W/S/NI','HE Wales, Scotland or Northern Ireland',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 32,0,1,'HE-OS','HE Overseas',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 33,0,1,'Teac-OS','Teacher Overseas',8);
insert into spd_dev.classifier(id,version,classification_level,classn_identifier,label,parent_id) values ( 34,0,1,'Teac-W/S/NI','Teacher Wales, Scotland or Northern Ireland',8);


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

insert into spd_dev.visit_postings(visit_id,classifier_id) select id,9 from spd_orig.schoolsvisits where (YearGroup1ID=1 or YearGroup2ID=1 or YearGroup3ID=1 or YearGroup4ID=1 or YearGroup5ID=1 or YearGroup6ID=1 or YearGroup7ID=1 or YearGroup8ID=1 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,10 from spd_orig.schoolsvisits where (YearGroup1ID=2 or YearGroup2ID=2 or YearGroup3ID=2 or YearGroup4ID=2 or YearGroup5ID=2 or YearGroup6ID=2 or YearGroup7ID=2 or YearGroup8ID=2 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,11 from spd_orig.schoolsvisits where (YearGroup1ID=3 or YearGroup2ID=3 or YearGroup3ID=3 or YearGroup4ID=3 or YearGroup5ID=3 or YearGroup6ID=3 or YearGroup7ID=3 or YearGroup8ID=3 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,12 from spd_orig.schoolsvisits where (YearGroup1ID=4 or YearGroup2ID=4 or YearGroup3ID=4 or YearGroup4ID=4 or YearGroup5ID=4 or YearGroup6ID=4 or YearGroup7ID=4 or YearGroup8ID=4 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,13 from spd_orig.schoolsvisits where (YearGroup1ID=5 or YearGroup2ID=5 or YearGroup3ID=5 or YearGroup4ID=5 or YearGroup5ID=5 or YearGroup6ID=5 or YearGroup7ID=5 or YearGroup8ID=5 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,14 from spd_orig.schoolsvisits where (YearGroup1ID=6 or YearGroup2ID=6 or YearGroup3ID=6 or YearGroup4ID=6 or YearGroup5ID=6 or YearGroup6ID=6 or YearGroup7ID=6 or YearGroup8ID=6 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,15 from spd_orig.schoolsvisits where (YearGroup1ID=7 or YearGroup2ID=7 or YearGroup3ID=7 or YearGroup4ID=7 or YearGroup5ID=7 or YearGroup6ID=7 or YearGroup7ID=7 or YearGroup8ID=7 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,16 from spd_orig.schoolsvisits where (YearGroup1ID=8 or YearGroup2ID=8 or YearGroup3ID=8 or YearGroup4ID=8 or YearGroup5ID=8 or YearGroup6ID=8 or YearGroup7ID=8 or YearGroup8ID=8 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,17 from spd_orig.schoolsvisits where (YearGroup1ID=9 or YearGroup2ID=9 or YearGroup3ID=9 or YearGroup4ID=9 or YearGroup5ID=9 or YearGroup6ID=9 or YearGroup7ID=9 or YearGroup8ID=9 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,18 from spd_orig.schoolsvisits where (YearGroup1ID=10 or YearGroup2ID=10 or YearGroup3ID=10 or YearGroup4ID=10 or YearGroup5ID=10 or YearGroup6ID=10 or YearGroup7ID=10 or YearGroup8ID=10 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,19 from spd_orig.schoolsvisits where (YearGroup1ID=11 or YearGroup2ID=11 or YearGroup3ID=11 or YearGroup4ID=11 or YearGroup5ID=11 or YearGroup6ID=11 or YearGroup7ID=11 or YearGroup8ID=11 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,20 from spd_orig.schoolsvisits where (YearGroup1ID=12 or YearGroup2ID=12 or YearGroup3ID=12 or YearGroup4ID=12 or YearGroup5ID=12 or YearGroup6ID=12 or YearGroup7ID=12 or YearGroup8ID=12 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,21 from spd_orig.schoolsvisits where (YearGroup1ID=13 or YearGroup2ID=13 or YearGroup3ID=13 or YearGroup4ID=13 or YearGroup5ID=13 or YearGroup6ID=13 or YearGroup7ID=13 or YearGroup8ID=13 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,22 from spd_orig.schoolsvisits where (YearGroup1ID=14 or YearGroup2ID=14 or YearGroup3ID=14 or YearGroup4ID=14 or YearGroup5ID=14 or YearGroup6ID=14 or YearGroup7ID=14 or YearGroup8ID=14 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,23 from spd_orig.schoolsvisits where (YearGroup1ID=15 or YearGroup2ID=15 or YearGroup3ID=15 or YearGroup4ID=15 or YearGroup5ID=15 or YearGroup6ID=15 or YearGroup7ID=15 or YearGroup8ID=15 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,24 from spd_orig.schoolsvisits where (YearGroup1ID=16 or YearGroup2ID=16 or YearGroup3ID=16 or YearGroup4ID=16 or YearGroup5ID=16 or YearGroup6ID=16 or YearGroup7ID=16 or YearGroup8ID=16 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,25 from spd_orig.schoolsvisits where (YearGroup1ID=17 or YearGroup2ID=17 or YearGroup3ID=17 or YearGroup4ID=17 or YearGroup5ID=17 or YearGroup6ID=17 or YearGroup7ID=17 or YearGroup8ID=17 );

insert into spd_dev.visit_postings(visit_id,classifier_id) select id,26 from spd_orig.schoolsvisits where (YearGroup1ID=18 or YearGroup2ID=18 or YearGroup3ID=18 or YearGroup4ID=18 or YearGroup5ID=18 or YearGroup6ID=18 or YearGroup7ID=18 or YearGroup8ID=18 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,27 from spd_orig.schoolsvisits where (YearGroup1ID=19 or YearGroup2ID=19 or YearGroup3ID=19 or YearGroup4ID=19 or YearGroup5ID=19 or YearGroup6ID=19 or YearGroup7ID=19 or YearGroup8ID=19 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,28 from spd_orig.schoolsvisits where (YearGroup1ID=20 or YearGroup2ID=20 or YearGroup3ID=20 or YearGroup4ID=20 or YearGroup5ID=20 or YearGroup6ID=20 or YearGroup7ID=20 or YearGroup8ID=20 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,29 from spd_orig.schoolsvisits where (YearGroup1ID=21 or YearGroup2ID=21 or YearGroup3ID=21 or YearGroup4ID=21 or YearGroup5ID=21 or YearGroup6ID=21 or YearGroup7ID=21 or YearGroup8ID=21 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,30 from spd_orig.schoolsvisits where (YearGroup1ID=22 or YearGroup2ID=22 or YearGroup3ID=22 or YearGroup4ID=22 or YearGroup5ID=22 or YearGroup6ID=22 or YearGroup7ID=22 or YearGroup8ID=22 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,31 from spd_orig.schoolsvisits where (YearGroup1ID=23 or YearGroup2ID=23 or YearGroup3ID=23 or YearGroup4ID=23 or YearGroup5ID=23 or YearGroup6ID=23 or YearGroup7ID=23 or YearGroup8ID=23 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,32 from spd_orig.schoolsvisits where (YearGroup1ID=24 or YearGroup2ID=24 or YearGroup3ID=24 or YearGroup4ID=24 or YearGroup5ID=24 or YearGroup6ID=24 or YearGroup7ID=24 or YearGroup8ID=24 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,33 from spd_orig.schoolsvisits where (YearGroup1ID=25 or YearGroup2ID=25 or YearGroup3ID=25 or YearGroup4ID=25 or YearGroup5ID=25 or YearGroup6ID=25 or YearGroup7ID=25 or YearGroup8ID=25 );
insert into spd_dev.visit_postings(visit_id,classifier_id) select id,34 from spd_orig.schoolsvisits where (YearGroup1ID=26 or YearGroup2ID=26 or YearGroup3ID=26 or YearGroup4ID=26 or YearGroup5ID=26 or YearGroup6ID=26 or YearGroup7ID=26 or YearGroup8ID=26 );

