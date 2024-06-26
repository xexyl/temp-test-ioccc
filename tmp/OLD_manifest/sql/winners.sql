CREATE TABLE winners (
	prize_tag TEXT,
	person_id TEXT,
	country TEXT,
	city TEXT,
	CONSTRAINT winners UNIQUE (prize_tag, person_id) ON CONFLICT REPLACE
);
INSERT INTO winners VALUES('2000_anderson','Glyn_Anderson',NULL,NULL);
INSERT INTO winners VALUES('1984_anonymous','Anonymous_1984',NULL,NULL);
INSERT INTO winners VALUES('2004_anonymous','Anonymous_2004',NULL,NULL);
INSERT INTO winners VALUES('1991_davidguy','David_Applegate',NULL,NULL);
INSERT INTO winners VALUES('1985_applin','Jack_Applin',NULL,NULL);
INSERT INTO winners VALUES('1986_applin','Jack_Applin',NULL,NULL);
INSERT INTO winners VALUES('1988_applin','Jack_Applin',NULL,NULL);
INSERT INTO winners VALUES('1989_jar.1','Jari_Arkko',NULL,NULL);
INSERT INTO winners VALUES('1989_jar.2','Jari_Arkko',NULL,NULL);
INSERT INTO winners VALUES('2000_jarijyrki','Jari_Arkko',NULL,NULL);
INSERT INTO winners VALUES('1985_august','Lennart_Augustsson',NULL,NULL);
INSERT INTO winners VALUES('1986_august','Lennart_Augustsson',NULL,NULL);
INSERT INTO winners VALUES('1996_august','Lennart_Augustsson',NULL,NULL);
INSERT INTO winners VALUES('1998_banks','Carl_Banks',NULL,NULL);
INSERT INTO winners VALUES('2001_anonymous','Anonymous_2001',NULL,NULL);
INSERT INTO winners VALUES('2004_gavin','Gavin_Barraclough',NULL,NULL);
INSERT INTO winners VALUES('1991_buzzard','Sean_Barrett',NULL,NULL);
INSERT INTO winners VALUES('1992_buzzard.1','Sean_Barrett',NULL,NULL);
INSERT INTO winners VALUES('1992_buzzard.2','Sean_Barrett',NULL,NULL);
INSERT INTO winners VALUES('2001_dgbeards','Doug_Beardsley',NULL,NULL);
INSERT INTO winners VALUES('2000_bellard','Fabrice_Bellard',NULL,NULL);
INSERT INTO winners VALUES('2001_bellard','Fabrice_Bellard',NULL,NULL);
INSERT INTO winners VALUES('1993_ejb','E._Jay_Berkenbilt',NULL,NULL);
INSERT INTO winners VALUES('1991_brnstnd','Daniel_J._Bernstein',NULL,NULL);
INSERT INTO winners VALUES('1987_biggar','Mark_Biggar',NULL,NULL);
INSERT INTO winners VALUES('1989_paul','Paul_E._Black',NULL,NULL);
INSERT INTO winners VALUES('1991_rince','James_Bonfield',NULL,NULL);
INSERT INTO winners VALUES('1993_rince','James_Bonfield',NULL,NULL);
INSERT INTO winners VALUES('2000_rince','James_Bonfield',NULL,NULL);
INSERT INTO winners VALUES('2000_briddlebane','Moxen_N._Briddlebane',NULL,NULL);
INSERT INTO winners VALUES('1986_bright','Walter_Bright',NULL,NULL);
INSERT INTO winners VALUES('1993_leo','Leonid_A._Broukhis',NULL,NULL);
INSERT INTO winners VALUES('1995_leo','Leonid_A._Broukhis',NULL,NULL);
INSERT INTO winners VALUES('1994_ldb','Laurion_Burchall',NULL,NULL);
INSERT INTO winners VALUES('2004_burley','Brent_Burley',NULL,NULL);
INSERT INTO winners VALUES('2000_thadgavin','Gavin_Buttimore',NULL,NULL);
INSERT INTO winners VALUES('2000_primenum','Raymond_Cheong',NULL,NULL);
INSERT INTO winners VALUES('2001_cheong','Raymond_Cheong',NULL,NULL);
INSERT INTO winners VALUES('1992_imc','Ian_Collier',NULL,NULL);
INSERT INTO winners VALUES('1994_imc','Ian_Collier',NULL,NULL);
INSERT INTO winners VALUES('2001_coupard','Pierre-Philippe_Coupard',NULL,NULL);
INSERT INTO winners VALUES('1996_dalbec','John_Dalbec',NULL,NULL);
INSERT INTO winners VALUES('2004_jdalbec','John_Dalbec',NULL,NULL);
INSERT INTO winners VALUES('1988_dale','Paul_Dale',NULL,NULL);
INSERT INTO winners VALUES('1998_bas1','Bas_de_Bakker',NULL,NULL);
INSERT INTO winners VALUES('1998_bas2','Bas_de_Bakker',NULL,NULL);
INSERT INTO winners VALUES('1998_chaos','Alan_De_Smet',NULL,NULL);
INSERT INTO winners VALUES('1984_decot','Dave_Decot',NULL,NULL);
INSERT INTO winners VALUES('1995_esde','Sebastian_Deorowicz',NULL,NULL);
INSERT INTO winners VALUES('1994_dodsond1','Don_Dodson',NULL,NULL);
INSERT INTO winners VALUES('1994_dodsond2','Don_Dodson',NULL,NULL);
INSERT INTO winners VALUES('1995_dodsond1','Don_Dodson',NULL,NULL);
INSERT INTO winners VALUES('1995_dodsond2','Don_Dodson',NULL,NULL);
INSERT INTO winners VALUES('1990_tbr','Sean_Dorward',NULL,NULL);
INSERT INTO winners VALUES('1995_heathbar','Heather_Downs',NULL,NULL);
INSERT INTO winners VALUES('1995_heathbar','Selene_Makarios',NULL,NULL);
INSERT INTO winners VALUES('1995_cdua','Carlos_Duarte',NULL,NULL);
INSERT INTO winners VALUES('1991_cdupont','Christian_Dupont',NULL,NULL);
INSERT INTO winners VALUES('1990_jaw','Paul_Eggert',NULL,NULL);
INSERT INTO winners VALUES('1996_eldby','Thor_Eldby',NULL,NULL);
INSERT INTO winners VALUES('1998_fanf','Tony_Finch',NULL,NULL);
INSERT INTO winners VALUES('1991_fine','Thomas_A._Fine',NULL,NULL);
INSERT INTO winners VALUES('1998_df','Daniel_Fischer',NULL,NULL);
INSERT INTO winners VALUES('1990_jaw','Karl_F._Fox',NULL,NULL);
INSERT INTO winners VALUES('2000_thadgavin','Thaddaeus_Frogley',NULL,NULL);
INSERT INTO winners VALUES('2004_gavare','Anders_Gavare',NULL,NULL);
INSERT INTO winners VALUES('1993_dgibson','David_Gibson',NULL,NULL);
INSERT INTO winners VALUES('1995_garry','Garry_Glendown',NULL,NULL);
INSERT INTO winners VALUES('1990_dg','David_Goodenough',NULL,NULL);
INSERT INTO winners VALUES('1992_gson','Andreas_Gustafsson',NULL,NULL);
INSERT INTO winners VALUES('1986_hague','Jim_Hague',NULL,NULL);
INSERT INTO winners VALUES('1987_heckbert','Paul_Heckbert',NULL,NULL);
INSERT INTO winners VALUES('1985_applin','Robert_Heckendorn',NULL,NULL);
INSERT INTO winners VALUES('1990_stig','Stig_Hemmer',NULL,NULL);
INSERT INTO winners VALUES('2001_herrmann1','Immanuel_Herrmann',NULL,NULL);
INSERT INTO winners VALUES('2001_herrmann2','Immanuel_Herrmann',NULL,NULL);
INSERT INTO winners VALUES('1987_hines','Spencer_Hines',NULL,NULL);
INSERT INTO winners VALUES('1986_holloway','Bruce_Holloway',NULL,NULL);
INSERT INTO winners VALUES('1993_lmfjyh','Jyrki_Holopainen',NULL,NULL);
INSERT INTO winners VALUES('2000_jarijyrki','Jyrki_Holopainen',NULL,NULL);
INSERT INTO winners VALUES('1994_horton','Mary_Ann_Horton',NULL,NULL);
INSERT INTO winners VALUES('1991_ant','Anthony_C._Howe',NULL,NULL);
INSERT INTO winners VALUES('1992_ant','Anthony_C._Howe',NULL,NULL);
INSERT INTO winners VALUES('1993_ant','Anthony_C._Howe',NULL,NULL);
INSERT INTO winners VALUES('2004_hibachi','Anthony_C._Howe',NULL,NULL);
INSERT INTO winners VALUES('2004_hoyle','Jonathan_Hoyle',NULL,NULL);
INSERT INTO winners VALUES('1996_huffman','Ken_Huffman',NULL,NULL);
INSERT INTO winners VALUES('1988_isaak','Mark_Isaak',NULL,NULL);
INSERT INTO winners VALUES('2000_tomx','Thomas_P_John',NULL,NULL);
INSERT INTO winners VALUES('2004_arachnid','Nick_Johnson',NULL,NULL);
INSERT INTO winners VALUES('1990_scjones','Larry_Jones',NULL,NULL);
INSERT INTO winners VALUES('2001_ctk','Chris_King',NULL,NULL);
INSERT INTO winners VALUES('1992_kivinen','Tero_Kivinen',NULL,NULL);
INSERT INTO winners VALUES('2004_kopczynski','Eryk_Kopczynski',NULL,NULL);
INSERT INTO winners VALUES('1987_korn','David_Korn',NULL,NULL);
INSERT INTO winners VALUES('1984_laman','Mike_Laman',NULL,NULL);
INSERT INTO winners VALUES('1989_jar.2','Ora_Lassila',NULL,NULL);
INSERT INTO winners VALUES('1987_lievaart','Roemer_B._Lievaart',NULL,NULL);
INSERT INTO winners VALUES('1989_roemer','Roemer_B._Lievaart',NULL,NULL);
INSERT INTO winners VALUES('1988_litmaath','Maarten_Litmaath',NULL,NULL);
INSERT INTO winners VALUES('1998_dlowe','J_David_Lowe',NULL,NULL);
INSERT INTO winners VALUES('1998_dloweneil','J_David_Lowe',NULL,NULL);
INSERT INTO winners VALUES('2000_dlowe','J_David_Lowe',NULL,NULL);
INSERT INTO winners VALUES('1992_lush','Ed_Luke',NULL,NULL);
INSERT INTO winners VALUES('1985_lycklama','Ed_Lycklama',NULL,NULL);
INSERT INTO winners VALUES('1995_makarios','Selene_Makarios',NULL,NULL);
INSERT INTO winners VALUES('1995_makarios','Heather_Downs',NULL,NULL);
INSERT INTO winners VALUES('1992_marangon','Andrea_Marangoni',NULL,NULL);
INSERT INTO winners VALUES('1990_theorem','Adrian_Mariano',NULL,NULL);
INSERT INTO winners VALUES('1992_adrian','Adrian_Mariano',NULL,NULL);
INSERT INTO winners VALUES('1986_marshall','Eric_Marshall',NULL,NULL);
INSERT INTO winners VALUES('1996_rcm','Ron_McFarland',NULL,NULL);
INSERT INTO winners VALUES('2000_bmeyer','Bernd_Meyer',NULL,NULL);
INSERT INTO winners VALUES('1990_cmills','Christopher_Mills',NULL,NULL);
INSERT INTO winners VALUES('1993_cmills','Christopher_Mills',NULL,NULL);
INSERT INTO winners VALUES('1998_dloweneil','Neil_Mix',NULL,NULL);
INSERT INTO winners VALUES('1984_mullender','Sjoerd_Mullender',NULL,NULL);
INSERT INTO winners VALUES('2004_newbern','Jeff_Newbern',NULL,NULL);
INSERT INTO winners VALUES('1990_baruch','Baruch_Nissenbaum',NULL,NULL);
INSERT INTO winners VALUES('1989_jar.2','Esko_Nuutila',NULL,NULL);
INSERT INTO winners VALUES('2001_ollinger','Nicolas_Ollinger',NULL,NULL);
INSERT INTO winners VALUES('2001_jason','Jason_Orendorff',NULL,NULL);
INSERT INTO winners VALUES('1990_baruch','Doron_Osovlanski',NULL,NULL);
INSERT INTO winners VALUES('1986_pawka','Michael_H._Pawka',NULL,NULL);
INSERT INTO winners VALUES('1992_vern','Vern_Paxson',NULL,NULL);
INSERT INTO winners VALUES('1988_phillipps','Ian_Phillipps',NULL,NULL);
INSERT INTO winners VALUES('1993_plummer','Mark_Plummer',NULL,NULL);
INSERT INTO winners VALUES('2001_kev','Kevin_Pulo',NULL,NULL);
INSERT INTO winners VALUES('1990_tbr','Byron_Rakitzis',NULL,NULL);
INSERT INTO winners VALUES('1994_tvr','Teemu_Rantanen',NULL,NULL);
INSERT INTO winners VALUES('1988_reddy','Gopi_Reddy',NULL,NULL);
INSERT INTO winners VALUES('1988_robison','Arch_D_Robison',NULL,NULL);
INSERT INTO winners VALUES('1989_robison','Arch_D_Robison',NULL,NULL);
INSERT INTO winners VALUES('2000_robison','Arch_D_Robison',NULL,NULL);
INSERT INTO winners VALUES('2001_rosten','Edward_Rosten',NULL,NULL);
INSERT INTO winners VALUES('1990_pjr','Peter_J_Ruczynski',NULL,NULL);
INSERT INTO winners VALUES('1994_smr','Szymon_Rusinkiewicz',NULL,NULL);
INSERT INTO winners VALUES('1995_savastio','Michael_Savastio',NULL,NULL);
INSERT INTO winners VALUES('2000_schneiderwent','Craig_Schneiderwent',NULL,NULL);
INSERT INTO winners VALUES('1993_schnitzi','Mark_Schnitzius',NULL,NULL);
INSERT INTO winners VALUES('1994_schnitzi','Mark_Schnitzius',NULL,NULL);
INSERT INTO winners VALUES('1995_schnitzi','Mark_Schnitzius',NULL,NULL);
INSERT INTO winners VALUES('1995_vanschnitz','Mark_Schnitzius',NULL,NULL);
INSERT INTO winners VALUES('1998_schnitzi','Mark_Schnitzius',NULL,NULL);
INSERT INTO winners VALUES('2004_schnitzi','Mark_Schnitzius',NULL,NULL);
INSERT INTO winners VALUES('1996_schweikh1','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('1996_schweikh2','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('1996_schweikh3','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('1998_schweikh1','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('1998_schweikh2','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('1998_schweikh3','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('2001_schweikh','Jens_Schweikhardt',NULL,NULL);
INSERT INTO winners VALUES('1994_shapiro','Andrew_Shapiro',NULL,NULL);
INSERT INTO winners VALUES('1985_shapiro','Carl_Shapiro',NULL,NULL);
INSERT INTO winners VALUES('2000_natori','NATORI_Shin',NULL,NULL);
INSERT INTO winners VALUES('1985_sicherman','Col._G._L._Sicherman',NULL,NULL);
INSERT INTO winners VALUES('1992_nathan','Nathan_Sidwell',NULL,NULL);
INSERT INTO winners VALUES('1988_spinellis','Diomidis_Spinellis',NULL,NULL);
INSERT INTO winners VALUES('1990_dds','Diomidis_Spinellis',NULL,NULL);
INSERT INTO winners VALUES('1991_dds','Diomidis_Spinellis',NULL,NULL);
INSERT INTO winners VALUES('1995_spinellis','Diomidis_Spinellis',NULL,NULL);
INSERT INTO winners VALUES('1986_stein','Jan_Stein',NULL,NULL);
INSERT INTO winners VALUES('1996_gandalf','Dean_Swift',NULL,NULL);
INSERT INTO winners VALUES('2004_sds','Stephen_Sykes',NULL,NULL);
INSERT INTO winners VALUES('1993_jonth','Jon_Thingvold',NULL,NULL);
INSERT INTO winners VALUES('1996_jonth','Jon_Thingvold',NULL,NULL);
INSERT INTO winners VALUES('1998_tomtorfs','Tom Torfs',NULL,NULL);
INSERT INTO winners VALUES('1989_tromp','John_Tromp',NULL,NULL);
INSERT INTO winners VALUES('1989_vanb','David_Van_Brackle',NULL,NULL);
INSERT INTO winners VALUES('1993_vanb','David_Van_Brackle',NULL,NULL);
INSERT INTO winners VALUES('1995_vanschnitz','David_Van_Brackle',NULL,NULL);
INSERT INTO winners VALUES('1992_albert','Albert_van_der_Horst',NULL,NULL);
INSERT INTO winners VALUES('1998_dorssel','Frans van Dorsselaer',NULL,NULL);
INSERT INTO winners VALUES('1984_mullender','Robbert_van_Renesse',NULL,NULL);
INSERT INTO winners VALUES('2004_vik1','Daniel_Vik',NULL,NULL);
INSERT INTO winners VALUES('2004_vik2','Daniel_Vik',NULL,NULL);
INSERT INTO winners VALUES('1989_ovdluhe','Oskar_von_der_Luehe',NULL,NULL);
INSERT INTO winners VALUES('1989_fubar','Jay_Vosburgh',NULL,NULL);
INSERT INTO winners VALUES('1986_wall','Larry_Wall',NULL,NULL);
INSERT INTO winners VALUES('1987_wall','Larry_Wall',NULL,NULL);
INSERT INTO winners VALUES('1994_weisberg','Jeff_Weisberg',NULL,NULL);
INSERT INTO winners VALUES('1987_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1988_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1989_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1990_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1991_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1992_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1994_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('1996_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('2001_westley','Brian_Westley',NULL,NULL);
INSERT INTO winners VALUES('2001_williams','John_Williams',NULL,NULL);
INSERT INTO winners VALUES('1990_jaw','James_A._Woods',NULL,NULL);
INSERT INTO winners VALUES('2000_dhyang','Don_Yang',NULL,NULL);
INSERT INTO winners VALUES('2004_omoikane','Don_Yang',NULL,NULL);
INSERT INTO winners VALUES('2000_briddlebane','Lord_Zarbon',NULL,NULL);
INSERT INTO winners VALUES('2005_aidan','Aidan_Thornton',NULL,NULL);
INSERT INTO winners VALUES('2005_anon','Anonymous_2005',NULL,NULL);
INSERT INTO winners VALUES('2005_boutines','Francois_Boutines',NULL,NULL);
INSERT INTO winners VALUES('2005_chia','V._Chia',NULL,NULL);
INSERT INTO winners VALUES('2005_giljade','Gil_Dogon',NULL,NULL);
INSERT INTO winners VALUES('2005_jetro','Jetro_Lauha',NULL,NULL);
INSERT INTO winners VALUES('2005_klausler','Peter_Klausler',NULL,NULL);
INSERT INTO winners VALUES('2005_mikeash','Michael_Ash',NULL,NULL);
INSERT INTO winners VALUES('2005_mynx','Anthony_C._Howe',NULL,NULL);
INSERT INTO winners VALUES('2005_persano','Mauro_Persano',NULL,NULL);
INSERT INTO winners VALUES('2005_sykes','Stephen_Sykes',NULL,NULL);
INSERT INTO winners VALUES('2005_timwi','Arne_Heizmann',NULL,NULL);
INSERT INTO winners VALUES('2005_toledo','Oscar_Toledo_G.',NULL,NULL);
INSERT INTO winners VALUES('2005_vik','Daniel_Vik',NULL,NULL);
INSERT INTO winners VALUES('2005_vince','Vincent_Weaver',NULL,NULL);
INSERT INTO winners VALUES('2006_birken','Michael_Birken',NULL,NULL);
INSERT INTO winners VALUES('2006_borsanyi','Szabolcs_Borsanyi',NULL,NULL);
INSERT INTO winners VALUES('2006_grothe','Aaron_Grothe',NULL,NULL);
INSERT INTO winners VALUES('2006_hamre','Steinar_Hamre',NULL,NULL);
INSERT INTO winners VALUES('2006_meyer','Raphael_Meyer',NULL,NULL);
INSERT INTO winners VALUES('2006_monge','Maurizio_Monge',NULL,NULL);
INSERT INTO winners VALUES('2006_night','Christopher_Night',NULL,NULL);
INSERT INTO winners VALUES('2006_sloane','Andy_Sloane',NULL,NULL);
INSERT INTO winners VALUES('2006_stewart','Thomas_Stewart',NULL,NULL);
INSERT INTO winners VALUES('2006_sykes1','Stephen_Sykes',NULL,NULL);
INSERT INTO winners VALUES('2006_sykes2','Stephen_Sykes',NULL,NULL);
INSERT INTO winners VALUES('2006_toledo1','Oscar_Toledo_G.',NULL,NULL);
INSERT INTO winners VALUES('2006_toledo2','Oscar_Toledo_G.',NULL,NULL);
INSERT INTO winners VALUES('2006_toledo3','Oscar_Toledo_G.',NULL,NULL);
INSERT INTO winners VALUES('2011_blakely','Philip_Blakely','UK',NULL);
INSERT INTO winners VALUES('2011_borsanyi','Szabolcs_Borsanyi','Germany',NULL);
INSERT INTO winners VALUES('2011_dlowe','J_David_Lowe','USA',NULL);
INSERT INTO winners VALUES('2011_eastman','Peter_Eastman','USA',NULL);
INSERT INTO winners VALUES('2011_fredriksson','Kimmo_Fredriksson','Finland',NULL);
INSERT INTO winners VALUES('2011_goren','Uri_Goren','Israel',NULL);
INSERT INTO winners VALUES('2011_hou','Qiming_HOU','China',NULL);
INSERT INTO winners VALUES('2011_konno','Taketo_Konno','Japan',NULL);
INSERT INTO winners VALUES('2011_hamaji','Shinichiro_Hamaji','Japan',NULL);
INSERT INTO winners VALUES('2011_hamaji','bsoup','Japan',NULL);
INSERT INTO winners VALUES('2011_richards','Gregor_Richards','USA',NULL);
INSERT INTO winners VALUES('2011_toledo','Oscar_Toledo_G.','Mexico',NULL);
INSERT INTO winners VALUES('2011_vik','Daniel_Vik','USA',NULL);
INSERT INTO winners VALUES('2011_zucker','Matt_Zucker','USA',NULL);
INSERT INTO winners VALUES('2011_akari','Don_Yang','USA',NULL);
INSERT INTO winners VALUES('2012_hou','Qiming_HOU','CN',NULL);
INSERT INTO winners VALUES('2012_grothe','Aaron_Grothe','US',NULL);
INSERT INTO winners VALUES('2012_grothe','David_Madore','FR',NULL);
INSERT INTO winners VALUES('2012_konno','Taketo_Konno','JP',NULL);
INSERT INTO winners VALUES('2012_omoikane','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2012_kang','Seonghoon_Kang','KR',NULL);
INSERT INTO winners VALUES('2012_dlowe','J_David_Lowe','US',NULL);
INSERT INTO winners VALUES('2012_deckmyn','Alex_Deckmyn','BE',NULL);
INSERT INTO winners VALUES('2012_endoh2','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2012_blakely','Philip_Blakely','GB',NULL);
INSERT INTO winners VALUES('2012_tromp','John_Tromp','US',NULL);
INSERT INTO winners VALUES('2012_endoh1','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2012_vik','Daniel_Vik','US',NULL);
INSERT INTO winners VALUES('2012_hamano','Tsukasa_Hamano','JP',NULL);
INSERT INTO winners VALUES('2012_zeitak','Adar_Zeitak','IL',NULL);
INSERT INTO winners VALUES('2013_endoh3','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2013_cable1','Adrian_Cable','US',NULL);
INSERT INTO winners VALUES('2013_misaka','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2013_dlowe','J_David_Lowe','US',NULL);
INSERT INTO winners VALUES('2013_endoh1','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2013_morgan1','Yves-Marie_Morgan','FR',NULL);
INSERT INTO winners VALUES('2013_robison','Arch_D_Robison','US',NULL);
INSERT INTO winners VALUES('2013_hou','Qiming_HOU','CN',NULL);
INSERT INTO winners VALUES('2013_birken','Michael_Birken','US',NULL);
INSERT INTO winners VALUES('2013_endoh2','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2013_cable3','Adrian_Cable','US',NULL);
INSERT INTO winners VALUES('2013_morgan2','Yves-Marie_Morgan','FR',NULL);
INSERT INTO winners VALUES('2013_endoh4','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2013_mills','Christopher_Mills','US',NULL);
INSERT INTO winners VALUES('2013_cable2','Adrian_Cable','US',NULL);
INSERT INTO winners VALUES('2014_endoh1','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2014_morgan','Yves-Marie_Morgan','FR',NULL);
INSERT INTO winners VALUES('2014_maffiodo1','Sandro_Maffiodo','IT',NULL);
INSERT INTO winners VALUES('2014_birken','Michael_Birken','US',NULL);
INSERT INTO winners VALUES('2014_birken','Alexander_Prishchepov','US',NULL);
INSERT INTO winners VALUES('2014_sinon','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2014_deak','Ferenc_Deak','NO',NULL);
INSERT INTO winners VALUES('2014_skeggs','Cel_Skeggs','US',NULL);
INSERT INTO winners VALUES('2014_maffiodo2','Sandro_Maffiodo','IT',NULL);
INSERT INTO winners VALUES('2014_vik','Daniel_Vik','US',NULL);
INSERT INTO winners VALUES('2014_endoh2','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2014_wiedijk','Freek_Wiedijk','NL',NULL);
INSERT INTO winners VALUES('2015_mills1','Christopher_Mills','US',NULL);
INSERT INTO winners VALUES('2015_hou','Qiming_HOU','CN',NULL);
INSERT INTO winners VALUES('2015_endoh1','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2015_mills2','Christopher_Mills','US',NULL);
INSERT INTO winners VALUES('2015_dogon','Gil_Dogon','IL',NULL);
INSERT INTO winners VALUES('2015_endoh4','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2015_endoh3','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2015_schweikhardt','Jens_Schweikhardt','DE',NULL);
INSERT INTO winners VALUES('2015_endoh1','Anonymous_2015','JP',NULL);
INSERT INTO winners VALUES('2015_burton','Dave_Burton','US',NULL);
INSERT INTO winners VALUES('2015_duble','Etienne_Duble','FR',NULL);
INSERT INTO winners VALUES('2015_howe','Anthony_C._Howe','CA',NULL);
INSERT INTO winners VALUES('2015_endoh2','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2015_yang','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2015_muth','Dominik_Muth','DE',NULL);
INSERT INTO winners VALUES('2018_endoh2','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2018_giles','Edward_Giles','AU',NULL);
INSERT INTO winners VALUES('2018_yang','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2018_anderson','Derek_Anderson','US',NULL);
INSERT INTO winners VALUES('2018_ferguson','Cody_Ferguson','US',NULL);
INSERT INTO winners VALUES('2018_bellard','Fabrice_Bellard','FR',NULL);
INSERT INTO winners VALUES('2018_burton2','Dave_Burton','US',NULL);
INSERT INTO winners VALUES('2018_hou','Qiming_HOU','CN',NULL);
INSERT INTO winners VALUES('2018_ciura','Marcin_Ciura','PL',NULL);
INSERT INTO winners VALUES('2018_burton1','Dave_Burton','US',NULL);
INSERT INTO winners VALUES('2018_algmyr','Anton_Älgmyr','SE',NULL);
INSERT INTO winners VALUES('2018_vokes','Scott_Vokes','US',NULL);
INSERT INTO winners VALUES('2018_poikola','Timo_Poikola','FI',NULL);
INSERT INTO winners VALUES('2018_mills','Christopher_Mills','US',NULL);
INSERT INTO winners VALUES('2018_endoh1','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2019_lynn','Ben_Lynn','US',NULL);
INSERT INTO winners VALUES('2019_poikola','Timo_Poikola','FI',NULL);
INSERT INTO winners VALUES('2019_duble','Etienne_Duble','FR',NULL);
INSERT INTO winners VALUES('2019_ciura','Marcin_Ciura','PL',NULL);
INSERT INTO winners VALUES('2019_karns','Joshua_Karns','US',NULL);
INSERT INTO winners VALUES('2019_diels-grabsch1','Volker_Diels-Grabsch','DE',NULL);
INSERT INTO winners VALUES('2019_mills','Christopher_Mills','US',NULL);
INSERT INTO winners VALUES('2019_yang','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2019_giles','Edward_Giles','AU',NULL);
INSERT INTO winners VALUES('2019_burton','Dave_Burton','US',NULL);
INSERT INTO winners VALUES('2019_diels-grabsch2','Volker_Diels-Grabsch','DE',NULL);
INSERT INTO winners VALUES('2019_endoh','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2019_adamovsky','Ondřej_Adamovský','CZ',NULL);
INSERT INTO winners VALUES('2019_dogon','Gil_Dogon','IL',NULL);
INSERT INTO winners VALUES('2020_kurdyukov4','Ilya_Kurdyukov','RU',NULL);
INSERT INTO winners VALUES('2020_ferguson2','Cody_Ferguson','US',NULL);
INSERT INTO winners VALUES('2020_ferguson1','Cody_Ferguson','US',NULL);
INSERT INTO winners VALUES('2020_endoh2','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2020_yang','Don_Yang','US',NULL);
INSERT INTO winners VALUES('2020_giles','Edward_Giles','AU',NULL);
INSERT INTO winners VALUES('2020_tsoj','_tsoj','DE',NULL);
INSERT INTO winners VALUES('2020_endoh3','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2020_carlini','Nicholas_Carlini','US',NULL);
INSERT INTO winners VALUES('2020_endoh1','Yusuke_Endoh','JP',NULL);
INSERT INTO winners VALUES('2020_otterness','Nathan_Otterness','US',NULL);
INSERT INTO winners VALUES('2020_burton','Dave_Burton','US',NULL);
INSERT INTO winners VALUES('2020_kurdyukov2','Ilya_Kurdyukov','RU',NULL);
INSERT INTO winners VALUES('2020_kurdyukov3','Ilya_Kurdyukov','RU',NULL);
INSERT INTO winners VALUES('2020_kurdyukov1','Ilya_Kurdyukov','RU',NULL);

