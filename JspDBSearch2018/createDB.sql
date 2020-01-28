create table student_count(year varchar(4), area varchar(8)
			, k_total varchar(6), k_class varchar(6), k_perclass varchar(6)
			, e_total varchar(6), e_class varchar(6), e_perclass varchar(6)
			, m_total varchar(6), m_class varchar(6), m_perclass varchar(6)
			, h_total varchar(6), h_class varchar(6), h_perclass varchar(6));

create table searcher(ip varchar(15), year varchar(30), area varchar(30), school varchar(30));

load data local infile "report.dat" into table student_cjount fields terminated by '\t';