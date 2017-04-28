--EXAMPLE CHANGE!!!!

USE master
GO

IF DB_ID('JJABY') IS NOT NULL
	DROP DATABASE JJABY
GO


CREATE DATABASE JJABY
GO 

USE JJABY
GO

	/***** TABLE Taxonomy *****/
CREATE TABLE Taxonomy(
	TaxonomyID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	Domain			VARCHAR(20)							NULL,
	Kingdom			VARCHAR(20)							NULL,
	Phylum			VARCHAR(20)							NULL,
	Class			VARCHAR(20)							NULL,
	[Order]			VARCHAR(20)							NULL,
	Family			VARCHAR(20)							NULL,
	Genus			VARCHAR(20)							NOT NULL,
	Species			VARCHAR(20)							NOT NULL,
	SubSpecies		VARCHAR(20)							NULL
)
GO

	/***** TABLE Common Names *****/
	CREATE TABLE CommonName(
	CommonNameID	INT		PRIMARY KEY		IDENTITY	NOT NULL,
	CommonNameName	VARCHAR(20)							NOT NULL
)
GO

	/***** TABLE Species Location: Room *****/
CREATE TABLE Room(
	RoomID			INT		PRIMARY KEY		IDENTITY	NOT NULL,
	RoomName		VARCHAR(30)							NOT NULL
)
GO

	/***** TABLE Species Location: Section *****/
CREATE TABLE Section(
	SectionID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	RoomID			INT		REFERENCES Room(RoomID)		NOT NULL,
	SectionName		VARCHAR(50)							NULL
)
GO

	/***** TABLE Species Location: Cabinet *****/
CREATE TABLE Cabinet(
	CabinetID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	CabinetName		VARCHAR(5)							NOT NULL,
	SectionID		INT		REFERENCES Section(SectionID)	NULL
)
GO

	/***** TABLE Species Location: Drawer *****/
CREATE TABLE Drawer(
	DrawerID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	CabinetID		INT		REFERENCES Cabinet(CabinetID) NOT NULL,
	DrawerName		VARCHAR(10)							NOT NULL
)

	/***** TABLE Species *****/
CREATE TABLE Species(
	SpeciesID		INT		PRIMARY KEY		IDENTITY			NOT NULL,
	TaxonomyID		INT		REFERENCES Taxonomy(TaxonomyID)		NOT NULL,
	Size			VARCHAR(20)									NOT NULL,
	Details			XML		DEFAULT('<Population></Population>
									<Range></Range>
									<Threat></Threat>
									<Uses></Uses>
									<Ecology></Ecology>
									<Habitat></Habitat>
									<Size></Size>
									<Lifespan></Lifespan>
									<HaR></HaR>')		NOT NULL --Personal Connections(How to positively impact species or how species relates to individual)
)
GO



	/***** TABLE Locality *****/
CREATE TABLE Locality(
	LocalityID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	Country			VARCHAR(100)							NULL,
	[State]			VARCHAR(100)							NULL,
	County			VARCHAR(100)							NULL,
	Township		VARCHAR(100)							NULL,
	City			VARCHAR(100)							NULL,
	Coordinates		VARCHAR(30)								NULL, 
	[Description]		VARCHAR(500)							NULL
)
GO



	/***** TABLE Specimen *****/
CREATE TABLE Specimen(
	SpecimenID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID		INT		REFERENCES Species(SpeciesID)	NOT NULL, 
	DrawerID		INT		REFERENCES Drawer(DrawerID)		NOT NULL, 
	Sex				VARCHAR(1)								NULL,
	Age				VARCHAR(20)								NULL,
	AccessionNumber	VARCHAR(20)								NOT NULL,
	IdentifiedBy	VARCHAR(30)								NOT NULL,
	NatureOfIdentification		VARCHAR(30)					NOT NULL,	
	CollectedBy		VARCHAR(30)								NOT NULL, 
	DateCollected	DATE									NOT NULL,
	PresentedBy		VARCHAR(30)								NULL, 
	DatePresented	DATE									NULL,
	PreparedBy		VARCHAR(30)								NULL,
	DatePrepared	DATE									NULL,
	LocalityID		INT		REFERENCES Locality(LocalityID)	NOT NULL,  
	CollectingSource	VARCHAR(20)							NOT NULL,
	Recorded		XML										NOT NULL,
	EventDate		DATE									NOT NULL,
	VerificationStatus	VARCHAR(20)							NULL,
	OnDisplay		BIT										NOT NULL,
	Remarks			VARCHAR(500)							NULL
)
GO

	/***** TABLE PartType *****/   -- TEMPORARY FOR 385 PURPOSES. NEEDS REDONE
CREATE TABLE PartType(		
	PartTypeID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	AccessionNumberExtension	VARCHAR(20)					NOT NULL,
	SpecimenID		INT		REFERENCES Specimen(SpecimenID)	NOT NULL,
	PartType		VARCHAR(30)								NOT NULL,
	[Description]	VARCHAR(500)							NULL
)
GO

	/***** TABLE BodyMeasurements *****/  --TEMPORARY FOR 385 PURPOSES. NEEDS REDONE
CREATE TABLE BodyMeasurements( 
	BMID			INT		PRIMARY KEY		IDENTITY	NOT NULL,
	SpecimenID		INT		REFERENCES Specimen(SpecimenID)	NOT NULL,
	MeasurementType	VARCHAR(30)							NOT NULL,
	Measurement		DECIMAL								NOT NULL
)
GO

	/***** TABLE Exhibits *****/
CREATE TABLE Exhibits(
	ExhibitID		INT		PRIMARY KEY		IDENTITY					NOT NULL,
	ExhibitName		VARCHAR(20)											NOT NULL,
	ExhibitDetails	XML		DEFAULT('<Exhibit></Exhibit>')				NOT NULL
)
GO

	/***** TABLE Species to Exhibits Connections *****/
CREATE TABLE SpeciesAndExhibits(
	SpeciesID				INT		REFERENCES Species(SpeciesID)		NOT NULL,
	ExhibitID				INT		REFERENCES Exhibits(ExhibitID)		NOT NULL,
	PRIMARY KEY (SpeciesID, ExhibitID)
)
GO

	/***** TABLE Species to CommonName Connections *****/
CREATE TABLE SpeciesAndCommonNames(
	SpeciesID				INT		REFERENCES Species(SpeciesID)		NOT NULL,
	CommonNameID			INT		REFERENCES CommonName(CommonNameID)	NOT NULL,
	PRIMARY KEY (SpeciesID, CommonNameID)
)
GO

	/***** TABLE Species' Media (images, video, audio) *****/
CREATE TABLE SpeciesMedia(
	SpeciesMediaID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID			INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	MediaType			VARCHAR(15)								NOT NULL,
	[MediaURL]					varchar(1000)							NOT NULL,
	IsProtected			BIT										NOT NULL,
	FriendlyName		varchar(100)							NOT NULL,
	SpecimenID			INT		REFERENCES	Specimen(SpecimenID)	NULL,
	PartTypeID			INT		REFERENCES	PartType(PartTypeID)	NULL
)
GO

SET IDENTITY_INSERT Taxonomy ON
INSERT Taxonomy (TaxonomyID, Domain, Kingdom, Phylum, Class, [Order], Family, Genus, Species, SubSpecies) VALUES 
	(1, 'sit', 'eleifend', 'at', 'blandit', 'justo', 'magna', 'in', 'vestibulum', null),
	(2, null, null, null, null, null, null, 'donec', 'tellus', null),
	(3, 'id', 'vivamus', 'odio', 'accumsan', 'ipsum', 'congue', 'lorem', 'tincidunt', 'nam'),
	(4, 'ac', 'massa', 'ante', 'massa', 'lobortis', 'nunc', 'venenatis', 'ut', null),
	(5, null, null, null, null, null, null, 'quis', 'ultrices', null),
	(6, 'tristique', 'aenean', 'semper', 'nulla', 'maecenas', 'orci', 'dignissim', 'felis', 'nullam'),
	(7, null, null, null, null, null, null, 'non', 'aliquam', 'cras'),
	(8, 'duis', 'ut', 'mattis', 'aliquam', 'turpis', 'penatibus', 'orci', 'congue', null),
	(9, 'consequat', 'accumsan', 'in', 'nulla', 'nulla', 'turpis', 'integer', 'curae', null),
	(10, 'etiam', 'eros', 'pellentesque', 'laoreet', 'mollis', 'dictumst', 'non', 'mus', null),
	(11, null, null, null, null, null, null, 'dapibus', 'vehicula', 'amet'),
	(12, 'pretium', 'tortor', 'a', 'quam', 'eu', 'at', 'in', 'eu', null),
	(13, 'aliquam', 'ut', 'lectus', 'blandit', 'ante', 'congue', 'eu', 'mattis', null),
	(14, 'vehicula', 'ipsum', 'ipsum', 'nonummy', 'justo', 'sem', 'sagittis', 'nulla', null),
	(15, 'tortor', 'at', 'vestibulum', 'interdum', 'ut', 'sodales', 'lectus', 'ultrices', 'est'),
	(16, 'diam', 'faucibus', 'nascetur', 'vestibulum', 'nulla', 'mauris', 'vel', 'massa', null),
	(17, 'vestibulum', 'ipsum', 'placerat', 'sed', 'turpis', 'nunc', 'vel', 'tellus', null),
	(18, null, null, null, null, null, null, 'metus', 'morbi', null),
	(19, 'ut', 'ullamcorper', 'mauris', 'ultrices', 'congue', 'sem', 'dictumst', 'nisl', 'aliquam'),
	(20, 'ultrices', 'massa', 'sed', 'in', 'vel', 'semper', 'in', 'venenatis', 'cubilia')
SET IDENTITY_INSERT Taxonomy OFF
GO

SET IDENTITY_INSERT CommonName ON
INSERT CommonName (CommonNameID, CommonNameName) VALUES 
	(1, 'id'),
	(2, 'ultrices'),
	(3, 'dolor'),
	(4, 'at'),
	(5, 'integer'),
	(6, 'interdum'),
	(7, 'interdum'),
	(8, 'eu'),
	(9, 'leo'),
	(10, 'dolor'),
	(11, 'risus'),
	(12, 'nisi'),
	(13, 'vestibulum'),
	(14, 'sapien'),
	(15, 'hendrerit'),
	(16, 'viverra'),
	(17, 'luctus'),
	(18, 'consequat'),
	(19, 'nec'),
	(20, 'neque'),
	(21, 'proin'),
	(22, 'in'),
	(23, 'amet'),
	(24, 'odio'),
	(25, 'blandit'),
	(26, 'maecenas'),
	(27, 'ut'),
	(28, 'primis'),
	(29, 'amet'),
	(30, 'duis')
SET IDENTITY_INSERT CommonName OFF
GO

SET IDENTITY_INSERT Room ON
INSERT Room (RoomID, RoomName) VALUES
	(1, 'Lauree'),
	(2, 'Tybalt'),
	(3, 'Ilario'),
	(4, 'Veda'),
	(5, 'Bertrando'),
	(6, 'Ysabel')
SET IDENTITY_INSERT Room OFF
GO

SET IDENTITY_INSERT Section ON
INSERT Section (SectionID, RoomID, SectionName) VALUES
	(1, 6, 'Galea'),
	(2, 2, 'Robb'),
	(3, 5, 'Moralis'),
	(4, 2, 'Corstorphine'),
	(5, 6, 'Berens'),
	(6, 4, 'Ganiford'),
	(7, 6, 'Blissitt'),
	(8, 4, 'Breffit'),
	(9, 1, 'Feavers'),
	(10, 1, 'Alston'),
	(11, 5, 'Lightman'),
	(12, 1, 'Dytham'),
	(13, 4, 'Wieprecht'),
	(14, 2, 'Buddle'),
	(15, 6, 'Maulden')
SET IDENTITY_INSERT Section OFF
GO

SET IDENTITY_INSERT Cabinet ON
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (1, 12, 'ZA');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (2, null, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (3, 3, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (4, null, 'PE');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (5, 13, 'SE');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (6, 10, 'ID');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (7, null, 'CZ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (8, null, 'ID');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (9, 5, 'CZ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (10, null, 'AF');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (11, null, 'FR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (12, null, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (13, 6, 'MD');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (14, null, 'ID');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (15, null, 'EC');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (16, 1, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (17, 9, 'CO');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (18, 6, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (19, 3, 'KZ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (20, 4, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (21, null, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (22, 9, 'MA');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (23, 12, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (24, null, 'PH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (25, null, 'PH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (26, null, 'TZ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (27, 4, 'KP');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (28, null, 'RS');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (29, null, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (30, 3, 'SE');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (31, null, 'BF');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (32, null, 'PE');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (33, null, 'BR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (34, null, 'PH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (35, 11, 'IT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (36, 11, 'US');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (37, null, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (38, 1, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (39, null, 'LY');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (40, 9, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (41, null, 'IT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (42, null, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (43, null, 'SD');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (44, 14, 'FR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (45, null, 'RS');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (46, 8, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (47, null, 'SD');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (48, 15, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (49, null, 'EE');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (50, null, 'HU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (51, 14, 'CO');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (52, null, 'UA');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (53, null, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (54, null, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (55, 12, 'CO');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (56, 6, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (57, 9, 'CZ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (58, null, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (59, 11, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (60, null, 'MG');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (61, 9, 'UZ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (62, null, 'UA');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (63, null, 'FR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (64, 9, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (65, null, 'PH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (66, 14, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (67, 5, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (68, 3, 'GR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (69, 11, 'FR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (70, 12, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (71, 1, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (72, 10, 'RU');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (73, 8, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (74, 5, 'AF');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (75, null, 'US');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (76, null, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (77, null, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (78, 2, 'PH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (79, null, 'TH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (80, 7, 'TN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (81, 4, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (82, null, 'IQ');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (83, 11, 'PE');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (84, 14, 'CN');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (85, 8, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (86, 3, 'ID');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (87, null, 'FR');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (88, 15, 'PT');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (89, 1, 'TH');
	insert into Cabinet (CabinetID, SectionID, CabinetName) values (90, 5, 'LV');
SET IDENTITY_INSERT Cabinet OFF
GO

SET IDENTITY_INSERT Drawer ON
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (1, 83, 'BR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (2, 50, 'EE');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (3, 30, 'BY');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (4, 74, 'TH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (5, 87, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (6, 3, 'AR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (7, 20, 'FR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (8, 9, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (9, 47, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (10, 79, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (11, 14, 'BR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (12, 51, 'NC');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (13, 61, 'IR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (14, 49, 'ES');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (15, 36, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (16, 3, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (17, 89, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (18, 35, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (19, 48, 'IQ');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (20, 90, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (21, 22, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (22, 66, 'PA');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (23, 9, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (24, 77, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (25, 57, 'PA');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (26, 25, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (27, 4, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (28, 66, 'CU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (29, 7, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (30, 88, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (31, 25, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (32, 36, 'PE');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (33, 21, 'PT');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (34, 3, 'PL');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (35, 32, 'HN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (36, 49, 'RW');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (37, 5, 'PL');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (38, 29, 'BY');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (39, 52, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (40, 72, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (41, 51, 'PL');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (42, 38, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (43, 84, 'PL');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (44, 12, 'PS');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (45, 20, 'JP');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (46, 87, 'CO');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (47, 72, 'CO');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (48, 77, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (49, 78, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (50, 69, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (51, 18, 'LT');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (52, 47, 'GR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (53, 60, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (54, 64, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (55, 73, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (56, 4, 'JP');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (57, 66, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (58, 74, 'AR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (59, 2, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (60, 3, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (61, 59, 'GH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (62, 52, 'BR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (63, 11, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (64, 43, 'FR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (65, 57, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (66, 88, 'PT');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (67, 12, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (68, 62, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (69, 26, 'FR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (70, 87, 'BR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (71, 82, 'NL');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (72, 75, 'NL');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (73, 32, 'MX');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (74, 74, 'PY');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (75, 16, 'GN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (76, 28, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (77, 87, 'NO');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (78, 66, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (79, 65, 'GR');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (80, 87, 'CA');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (81, 86, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (82, 51, 'JP');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (83, 32, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (84, 35, 'PT');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (85, 45, 'CZ');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (86, 41, 'MY');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (87, 51, 'AX');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (88, 26, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (89, 20, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (90, 9, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (91, 90, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (92, 73, 'US');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (93, 34, 'YE');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (94, 78, 'PY');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (95, 43, 'ID');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (96, 28, 'PH');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (97, 63, 'CN');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (98, 35, 'JP');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (99, 90, 'RU');
	insert into Drawer (DrawerID, CabinetID, DrawerName) values (100, 3, 'RU');
SET IDENTITY_INSERT Drawer OFF
GO

SET IDENTITY_INSERT Species ON
	insert into Species (SpeciesID, TaxonomyID, Size) values (1, 1, 'S');
	insert into Species (SpeciesID, TaxonomyID, Size) values (2, 2, '3XL');
	insert into Species (SpeciesID, TaxonomyID, Size) values (3, 3, '2XL');
	insert into Species (SpeciesID, TaxonomyID, Size) values (4, 4, 'M');
	insert into Species (SpeciesID, TaxonomyID, Size) values (5, 5, '3XL');
	insert into Species (SpeciesID, TaxonomyID, Size) values (6, 6, 'M');
	insert into Species (SpeciesID, TaxonomyID, Size) values (7, 7, '2XL');
	insert into Species (SpeciesID, TaxonomyID, Size) values (8, 8, '2XL');
	insert into Species (SpeciesID, TaxonomyID, Size) values (9, 9, 'M');
	insert into Species (SpeciesID, TaxonomyID, Size) values (10, 10, '3XL');
	insert into Species (SpeciesID, TaxonomyID, Size) values (11, 11, 'XS');
	insert into Species (SpeciesID, TaxonomyID, Size) values (12, 12, 'L');
	insert into Species (SpeciesID, TaxonomyID, Size) values (13, 13, 'L');
	insert into Species (SpeciesID, TaxonomyID, Size) values (14, 14, 'M');
	insert into Species (SpeciesID, TaxonomyID, Size) values (15, 15, 'XS');
	insert into Species (SpeciesID, TaxonomyID, Size) values (16, 16, 'XS');
	insert into Species (SpeciesID, TaxonomyID, Size) values (17, 17, 'S');
	insert into Species (SpeciesID, TaxonomyID, Size) values (18, 18, 'XS');
	insert into Species (SpeciesID, TaxonomyID, Size) values (19, 19, 'S');
	insert into Species (SpeciesID, TaxonomyID, Size) values (20, 20, 'M');
SET IDENTITY_INSERT Species OFF
GO

SET IDENTITY_INSERT Locality ON
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (1, 'United States', 'Louisiana', 'Flight', 'Moldovan', 'Baton Rouge', null, null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (2, 'United States', 'Virginia', 'Marfield', 'Dari', null, null, null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (3, 'United States', null, 'Gillon', 'Nepali', null, null, 'Nunc rhoncus dui vel sem.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (4, 'United States', 'Ohio', null, null, 'Dayton', null, 'Donec semper sapien a libero.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (5, 'United States', 'Arizona', 'Petrillo', 'Punjabi', null, '3575099961192995', null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (6, 'United States', 'North Carolina', 'Chidlow', null, 'Raleigh', null, null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (7, 'United States', 'Tennessee', 'Mapis', null, null, null, null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (8, 'United States', 'Hawaii', 'Oxer', null, null, '3551667653149776', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (9, 'United States', 'New Mexico', 'Shrimpton', null, null, '3541782821871269', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (10, 'United States', 'Tennessee', 'Trickett', 'Ndebele', 'Chattanooga', null, null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (11, 'United States', 'Maryland', 'Gergely', 'Tswana', null, null, 'In sagittis dui vel nisl.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (12, null, 'New York', 'Corneljes', null, 'Albany', '5388027829191331', 'Integer ac leo.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (13, 'United States', null, 'Powlett', null, 'New York City', '201826769285995', null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (14, 'United States', 'Ohio', 'Benoiton', 'Hindi', null, '3584810533943791', 'Morbi non quam nec dui luctus rutrum.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (15, 'United States', null, null, null, null, null, 'Nulla suscipit ligula in lacus.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (16, 'United States', 'New Jersey', 'Padson', null, null, '4175005146593884', 'Pellentesque ultrices mattis odio.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (17, 'United States', 'Tennessee', null, 'Tswana', 'Murfreesboro', '6383310740583791', null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (18, 'United States', null, 'Greenroyd', null, 'Littleton', null, 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (19, null, 'Utah', 'Saice', 'Malagasy', null, null, null);
	insert into Locality (LocalityID, Country, State, County, Township, City, Coordinates, [Description]) values (20, 'United States', 'Oregon', 'Lowfill', null, 'Portland', '4175004090277263', null);
SET IDENTITY_INSERT Locality OFF
GO

SET IDENTITY_INSERT Specimen ON
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (1, 20, 6, 'M', 'Female', 'Yetta', 'Mara', 'Isac McCloid', 'Isac', '2017-02-28 01:19:10', 'Female', '2016-05-23 02:13:23', 'Isac Birckmann', '2016-05-23 03:15:36', 15, 'Junction', 'Tools', '2017-04-05 11:35:36', 'Maroon', 1, 'S');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (2, 13, 50, 'F', 'Male', 'Daveen', 'Gael', 'Sutherland Elphey', 'Sutherland', '2016-06-21 04:12:41', 'Female', '2017-04-07 07:46:57', 'Sutherland Wegman', '2016-08-17 04:36:28', 6, 'Lane', 'Electronics', '2017-02-25 03:28:59', 'Teal', 0, 'XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (3, 14, 12, 'M', 'Female', 'Agatha', 'Betty', 'Ludwig Sweetmore', 'Ludwig', '2016-12-21 20:19:28', 'Female', '2016-11-28 12:42:26', 'Ludwig Sissons', '2016-10-24 18:00:19', 12, 'Way', 'Books', '2017-03-27 09:36:53', null, 1, 'S');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (4, 5, 73, 'F', 'Female', 'Care', 'Hanna', 'Winn Ralphs', 'Winn', '2016-12-06 17:46:40', 'Male', '2016-06-16 12:28:04', 'Winn Wagstaff', '2017-03-21 06:45:42', 3, 'Alley', 'Home', '2016-10-18 04:47:09', 'Orange', 0, '2XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (5, 16, 2, 'F', 'Male', 'Dot', 'Rheta', 'Dar Harradence', 'Dar', '2016-10-16 23:38:55', 'Female', '2016-11-07 01:18:29', 'Dar Alder', '2017-03-24 18:50:57', 4, 'Park', 'Automotive', '2016-12-11 12:26:49', null, 0, 'XS');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (6, 20, 80, 'F', 'Male', 'Sutherlan', 'Holly', 'Rufe Rebichon', 'Rufe', '2017-02-15 22:29:15', 'Male', '2016-11-07 21:10:18', 'Rufe Fielders', '2016-08-02 09:13:17', 2, 'Alley', 'Electronics', '2016-06-23 04:34:37', 'Purple', 0, 'L');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (7, 6, 24, 'F', 'Female', 'Revkah', 'Kylen', 'Padriac Kesterton', 'Padriac', '2016-12-31 01:46:01', 'Female', '2017-02-15 21:12:05', 'Padriac Belfit', '2016-11-26 06:45:02', 8, 'Center', 'Computers', '2017-04-09 02:59:47', 'Aquamarine', 1, '3XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (8, 14, 96, 'F', 'Female', 'Sig', 'Glennis', 'Willey Blythin', 'Willey', '2017-01-17 04:36:31', 'Male', '2017-02-02 20:23:38', 'Willey Colchett', '2016-09-05 06:57:42', 1, 'Court', 'Jewelery', '2017-03-12 10:01:21', 'Puce', 0, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (9, 7, 65, 'M', 'Male', 'Cos', 'Blakeley', 'Jocko Layzell', 'Jocko', '2017-03-01 19:03:32', 'Male', '2016-08-22 06:44:26', 'Jocko Victor', '2017-01-22 06:43:36', 3, 'Junction', 'Grocery', '2016-06-29 03:34:32', 'Orange', 0, 'L');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (10, 5, 63, 'M', 'Female', 'Cristionna', 'Juanita', 'Darius Labern', 'Darius', '2017-03-04 11:43:12', 'Female', '2016-11-11 02:24:01', 'Darius Philpot', '2016-05-23 11:14:12', 1, 'Plaza', 'Baby', '2016-09-28 07:30:17', 'Green', 0, null);
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (11, 1, 96, 'F', 'Female', 'Arlin', 'Nita', 'Harp Attlee', 'Harp', '2017-03-02 07:06:26', 'Male', '2017-01-27 10:29:15', 'Harp Premble', '2016-05-30 06:41:37', 10, 'Avenue', 'Jewelery', '2017-03-20 15:49:40', 'Violet', 1, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (12, 17, 62, 'M', 'Male', 'Lorin', 'Perry', 'Kennan Schubert', 'Kennan', '2017-02-05 03:08:18', 'Male', '2017-03-05 02:04:18', 'Kennan Coffee', '2016-05-06 02:43:51', 6, 'Way', 'Beauty', '2017-01-18 03:47:09', null, 0, null);
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (13, 15, 94, 'F', 'Female', 'Sarina', 'Janenna', 'Russ Hedworth', 'Russ', '2016-05-04 12:50:36', 'Female', '2016-06-09 08:25:38', 'Russ Gwyer', '2017-04-22 09:00:02', 17, 'Park', 'Jewelery', '2016-06-01 02:22:42', 'Puce', 0, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (14, 6, 70, 'M', 'Male', 'Trisha', 'Eartha', 'Sylvan Snepp', 'Sylvan', '2016-07-09 11:12:41', 'Female', '2016-12-04 08:41:43', 'Sylvan Barnsley', '2016-09-15 12:48:51', 20, 'Point', 'Jewelery', '2017-02-18 12:44:21', null, 1, '3XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (15, 4, 15, 'F', 'Female', 'Sibylla', 'Marillin', 'Johan Beche', 'Johan', '2016-05-28 23:52:32', 'Female', '2016-12-16 14:18:15', 'Johan Ondrus', '2017-01-26 21:55:21', 15, 'Trail', 'Games', '2017-04-07 00:25:29', 'Teal', 1, 'S');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (16, 12, 34, 'M', 'Male', 'Halsey', 'Alla', 'Fremont Doring', 'Fremont', '2016-11-20 02:17:13', 'Male', '2016-11-07 02:47:19', 'Fremont Pollak', '2016-10-01 03:44:16', 19, 'Crossing', 'Sports', '2017-03-30 14:15:28', null, 0, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (17, 15, 67, 'F', 'Male', 'Rhetta', 'Quintilla', 'Frannie Grinyer', 'Frannie', '2016-10-24 11:06:42', 'Female', '2017-01-26 23:53:54', 'Frannie Cyphus', '2016-05-21 14:32:26', 5, 'Crossing', 'Games', '2016-07-04 03:34:25', 'Pink', 0, 'XS');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (18, 18, 23, 'M', 'Female', 'Teirtza', 'Henryetta', 'Salim Fennelow', 'Salim', '2016-07-06 23:27:29', 'Female', '2017-02-08 11:44:37', 'Salim Swabey', '2016-07-18 09:43:48', 10, 'Crossing', 'Automotive', '2016-06-22 16:51:17', 'Khaki', 0, null);
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (19, 18, 70, 'F', 'Male', 'Marsiella', 'Priscella', 'Gibbie Shurmore', 'Gibbie', '2016-07-15 00:25:50', 'Female', '2016-06-06 18:55:39', 'Gibbie Gathercole', '2016-05-11 23:13:53', 19, 'Alley', 'Baby', '2016-05-11 11:17:30', 'Red', 1, 'XS');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (20, 1, 80, 'M', 'Male', 'Ola', 'Donnie', 'Boris Brownsett', 'Boris', '2016-07-30 09:13:41', 'Female', '2016-11-11 11:14:28', 'Boris Annatt', '2016-08-23 21:54:09', 10, 'Hill', 'Beauty', '2016-09-23 17:59:04', 'Turquoise', 0, null);
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (21, 15, 88, 'M', 'Female', 'Patience', 'Janot', 'Case Shakeshaft', 'Case', '2016-05-12 22:54:33', 'Female', '2017-03-12 21:00:58', 'Case Felce', '2016-05-22 11:47:01', 3, 'Alley', 'Sports', '2016-10-10 23:43:56', 'Khaki', 0, 'XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (22, 14, 29, 'F', 'Female', 'Goldarina', 'Flo', 'Heall Cheng', 'Heall', '2017-03-18 02:23:22', 'Female', '2017-03-12 20:20:10', 'Heall Earney', '2016-09-03 00:12:06', 1, 'Plaza', 'Music', '2017-03-12 03:23:46', 'Red', 0, '3XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (23, 9, 7, 'M', 'Male', 'Haskell', 'Timmi', 'Upton Bearns', 'Upton', '2016-09-06 13:47:55', 'Male', '2016-06-13 07:06:56', 'Upton Sleith', '2016-10-08 17:02:32', 18, 'Point', 'Home', '2016-09-04 21:03:17', 'Yellow', 1, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (24, 19, 23, 'M', 'Male', 'Wiley', 'Ilysa', 'Ashby Witard', 'Ashby', '2017-02-07 23:31:50', 'Male', '2016-12-24 21:21:46', 'Ashby Mainz', '2017-03-24 08:17:32', 8, 'Avenue', 'Games', '2016-12-24 06:12:02', null, 0, 'S');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (25, 9, 35, 'M', 'Female', 'Jeana', 'Maritsa', 'Max Canaan', 'Max', '2016-10-26 13:15:32', 'Female', '2016-09-05 17:07:17', 'Max Fasler', '2017-01-24 19:08:30', 4, 'Plaza', 'Tools', '2016-09-19 07:12:08', 'Violet', 0, 'S');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (26, 11, 28, 'F', 'Female', 'Eben', 'Dareen', 'Devlin Mc Caghan', 'Devlin', '2016-05-24 04:06:46', 'Male', '2016-07-13 07:01:04', 'Devlin Greenhill', '2016-05-12 15:24:22', 16, 'Hill', 'Music', '2017-04-24 02:57:45', null, 1, '2XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (27, 19, 80, 'M', 'Female', 'Hermann', 'Arlinda', 'Cazzie Bertouloume', 'Cazzie', '2016-12-21 00:06:11', 'Male', '2016-11-17 08:21:14', 'Cazzie Teffrey', '2017-01-29 10:53:15', 15, 'Center', 'Books', '2016-12-14 06:19:43', 'Blue', 1, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (28, 4, 32, 'M', 'Female', 'Cash', 'Phylys', 'Franzen Hatherill', 'Franzen', '2016-09-14 08:09:54', 'Male', '2017-01-03 20:20:07', 'Franzen Woollett', '2016-05-04 21:36:06', 16, 'Parkway', 'Games', '2016-12-13 11:10:19', null, 0, 'S');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (29, 13, 85, 'M', 'Male', 'Olva', 'Colly', 'Davide Hunnaball', 'Davide', '2016-07-26 03:51:44', 'Female', '2016-12-27 18:43:46', 'Davide Marginson', '2017-01-16 13:07:59', 9, 'Drive', 'Electronics', '2017-01-02 15:23:47', 'Blue', 0, '2XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (30, 13, 62, 'M', 'Female', 'Brent', 'Jamie', 'Verne Boylund', 'Verne', '2016-12-21 07:04:32', 'Male', '2016-09-12 05:18:12', 'Verne Lomen', '2016-05-23 08:21:49', 8, 'Road', 'Movies', '2017-04-10 09:44:01', 'Purple', 1, 'XS');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (31, 4, 17, 'M', 'Female', 'Lenore', 'Jacquenette', 'Ludwig Cane', 'Ludwig', '2016-07-09 10:29:12', 'Female', '2017-01-19 00:43:11', 'Ludwig Scurman', '2016-08-05 12:14:27', 12, 'Drive', 'Electronics', '2016-06-22 04:11:27', null, 1, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (32, 13, 1, 'F', 'Male', 'Raphaela', 'Marguerite', 'Der Somerled', 'Der', '2016-08-23 08:50:34', 'Female', '2017-02-05 03:25:30', 'Der Penhale', '2016-08-20 14:45:26', 11, 'Junction', 'Jewelery', '2016-12-16 13:52:45', null, 0, null);
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (33, 11, 30, 'F', 'Male', 'Scott', 'Andra', 'Patty Wagstaffe', 'Patty', '2016-09-29 06:39:33', 'Male', '2017-02-16 12:54:41', 'Patty Poulsom', '2016-11-24 01:50:48', 3, 'Park', 'Automotive', '2016-09-18 17:43:16', 'Goldenrod', 1, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (34, 17, 16, 'F', 'Male', 'Trenna', 'Anetta', 'Bartie Blenkhorn', 'Bartie', '2016-05-12 17:00:00', 'Female', '2016-09-24 18:44:34', 'Bartie Uttridge', '2016-11-04 02:58:15', 2, 'Court', 'Movies', '2017-01-28 16:15:00', 'Violet', 1, 'XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (35, 2, 55, 'M', 'Male', 'Marissa', 'Harrietta', 'Brigg Spiby', 'Brigg', '2016-09-19 22:24:18', 'Female', '2016-08-22 08:20:07', 'Brigg Pulman', '2016-11-18 22:25:14', 9, 'Pass', 'Books', '2016-08-08 02:53:24', 'Teal', 0, 'M');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (36, 1, 91, 'M', 'Male', 'Garner', 'Giovanna', 'Hewet Franz-Schoninger', 'Hewet', '2017-01-25 16:58:41', 'Male', '2016-08-27 15:29:03', 'Hewet Greep', '2016-10-21 19:03:53', 19, 'Parkway', 'Computers', '2016-07-02 15:21:37', 'Maroon', 0, 'L');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (37, 16, 55, 'F', 'Male', 'Walden', 'Wenda', 'Lewie Walling', 'Lewie', '2016-11-17 16:43:35', 'Male', '2016-10-27 18:33:49', 'Lewie Lumpkin', '2016-09-30 00:43:30', 9, 'Terrace', 'Movies', '2016-12-02 20:00:07', null, 1, null);
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (38, 16, 50, 'F', 'Male', 'Allie', 'Austina', 'Meredith Chantler', 'Meredith', '2016-10-26 09:52:42', 'Male', '2016-09-13 08:37:23', 'Meredith McGaraghan', '2017-02-16 17:03:04', 6, 'Place', 'Beauty', '2016-11-19 08:03:13', 'Teal', 1, 'XS');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (39, 11, 53, 'F', 'Male', 'Cori', 'Camella', 'Arvie Caldecourt', 'Arvie', '2016-08-18 05:17:49', 'Female', '2016-05-30 07:42:16', 'Arvie Torritti', '2016-11-07 23:42:14', 10, 'Way', 'Clothing', '2016-05-26 08:12:54', 'Goldenrod', 1, '3XL');
	insert into Specimen (SpecimenID, SpeciesID, DrawerID, Sex, Age, AccessionNumber, IdentifiedBy, NatureOfIdentification, CollectedBy, DateCollected, PresentedBy, DatePresented, PreparedBy, DatePrepared, LocalityID, CollectingSource, Recorded, EventDate, VerificationStatus, OnDisplay, Remarks) values (40, 16, 65, 'M', 'Female', 'Reynolds', 'Patrizia', 'Van Springate', 'Van', '2017-03-22 15:07:57', 'Male', '2016-06-17 23:41:34', 'Van Wimms', '2017-02-06 01:48:00', 19, 'Court', 'Health', '2016-05-13 19:13:49', 'Khaki', 1, '2XL');
SET IDENTITY_INSERT Specimen OFF
GO

SET IDENTITY_INSERT PartType ON
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (1, 'Hall', 28, 'Tlingit-Haida', 'Aliquam erat volutpat.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (2, 'Nora', 31, 'Polynesian', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (3, 'Maddie', 15, 'White', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (4, 'Joelynn', 38, 'Nicaraguan', 'Duis aliquam convallis nunc.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (5, 'Albertine', 24, 'Paraguayan', 'Nullam varius.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (6, 'Mella', 30, 'Asian Indian', 'Curabitur convallis.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (7, 'Stinky', 39, 'American Indian and Alaska Native (AIAN)', 'Morbi vel lectus in quam fringilla rhoncus.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (8, 'Marsiella', 2, 'Asian Indian', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (9, 'Gare', 34, 'Yakama', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (10, 'Filia', 30, 'Argentinian', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (11, 'Say', 31, 'Cherokee', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (12, 'Skipper', 21, 'Colville', 'Integer non velit.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (13, 'Melinda', 21, 'Hmong', 'Integer ac leo.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (14, 'Gary', 25, 'Yaqui', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (15, 'Diarmid', 25, 'Yakama', 'Aenean fermentum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (16, 'Sunshine', 15, 'Panamanian', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (17, 'Cristy', 31, 'Creek', 'Curabitur gravida nisi at nibh.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (18, 'Alejandro', 13, 'Native Hawaiian', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (19, 'Agnesse', 31, 'Colombian', 'Nullam molestie nibh in lectus.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (20, 'Ansley', 9, 'Ottawa', 'Integer tincidunt ante vel ipsum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (21, 'Terrance', 25, 'Malaysian', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (22, 'Boothe', 4, 'Chippewa', 'Phasellus in felis.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (23, 'Web', 19, 'Chinese', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (24, 'Maynord', 37, 'American Indian and Alaska Native (AIAN)', 'Donec dapibus.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (25, 'Viviyan', 31, 'Chamorro', 'Duis at velit eu est congue elementum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (26, 'Camile', 16, 'Malaysian', 'Sed sagittis.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (27, 'Ephrem', 39, 'Japanese', 'Vestibulum ac est lacinia nisi venenatis tristique.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (28, 'Eugen', 22, 'White', 'Aliquam sit amet diam in magna bibendum imperdiet.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (29, 'Iain', 19, 'Yakama', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (30, 'Idaline', 33, 'Cuban', 'Phasellus id sapien in sapien iaculis congue.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (31, 'Manny', 3, 'Guatemalan', 'Proin eu mi.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (32, 'Kellen', 22, 'Chippewa', 'Aenean fermentum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (33, 'Roseanna', 40, 'Kiowa', 'Morbi non quam nec dui luctus rutrum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (34, 'Josias', 28, 'Chinese', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (35, 'Valerye', 8, 'Fijian', 'Maecenas pulvinar lobortis est.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (36, 'Zsa zsa', 2, 'Chickasaw', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (37, 'Gael', 36, 'Bangladeshi', 'Nulla facilisi.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (38, 'Denys', 24, 'Chamorro', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (39, 'Jermayne', 29, 'Pakistani', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (40, 'Abdel', 40, 'Pima', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (41, 'Hector', 22, 'Chippewa', 'Suspendisse ornare consequat lectus.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (42, 'Lisetta', 5, 'Salvadoran', 'Duis ac nibh.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (43, 'Brion', 12, 'South American', 'Aenean auctor gravida sem.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (44, 'Roderigo', 6, 'Seminole', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (45, 'Maridel', 32, 'Puerto Rican', 'Phasellus sit amet erat.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (46, 'Dionisio', 15, 'Nicaraguan', 'Mauris lacinia sapien quis libero.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (47, 'Birch', 32, 'Tlingit-Haida', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (48, 'Rossy', 26, 'Thai', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (49, 'Daryl', 11, 'Potawatomi', 'In eleifend quam a odio.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (50, 'Arlan', 15, 'Fijian', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (51, 'Upton', 36, 'Delaware', 'Duis bibendum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (52, 'Tymon', 35, 'South American', 'Cras in purus eu magna vulputate luctus.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (53, 'Lissa', 30, 'Shoshone', 'Duis bibendum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (54, 'Gradey', 14, 'Cambodian', 'Donec dapibus.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (55, 'Sergei', 13, 'Mexican', 'Aenean auctor gravida sem.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (56, 'Luce', 27, 'Thai', 'Vivamus in felis eu sapien cursus vestibulum.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (57, 'Evin', 9, 'Tongan', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (58, 'Carr', 27, 'Paraguayan', 'Fusce consequat.');
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (59, 'Delainey', 23, 'Eskimo', null);
	insert into PartType (PartTypeID, AccessionNumberExtension, SpecimenID, PartType, [Description]) values (60, 'Hannah', 34, 'Costa Rican', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
SET IDENTITY_INSERT PartType OFF
GO

SET IDENTITY_INSERT BodyMeasurements ON
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (1, 1, 'Samoan', 74);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (2, 2, 'Sioux', 64);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (3, 3, 'Cuban', 51);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (4, 4, 'Peruvian', 7);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (5, 5, 'Cuban', 98);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (6, 6, 'Ecuadorian', 27);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (7, 7, 'Lumbee', 2);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (8, 8, 'Puerto Rican', 84);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (9, 9, 'Chinese', 31);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (10, 10, 'Yakama', 98);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (11, 11, 'Indonesian', 12);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (12, 12, 'Yuman', 93);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (13, 13, 'Pima', 44);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (14, 14, 'Pima', 37);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (15, 15, 'Ottawa', 62);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (16, 16, 'Polynesian', 38);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (17, 17, 'Korean', 65);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (18, 18, 'Chinese', 15);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (19, 19, 'Taiwanese', 64);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (20, 20, 'Fijian', 92);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (21, 21, 'Colombian', 35);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (22, 22, 'Comanche', 67);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (23, 23, 'Venezuelan', 97);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (24, 24, 'Tlingit-Haida', 45);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (25, 25, 'Cree', 15);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (26, 26, 'Sioux', 2);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (27, 27, 'Delaware', 76);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (28, 28, 'Alaskan Athabascan', 1);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (29, 29, 'Iroquois', 62);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (30, 30, 'Malaysian', 29);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (31, 31, 'Japanese', 2);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (32, 32, 'Pakistani', 6);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (33, 33, 'Delaware', 39);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (34, 34, 'Kiowa', 8);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (35, 35, 'White', 94);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (36, 36, 'Potawatomi', 36);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (37, 37, 'Taiwanese', 1);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (38, 38, 'Sioux', 89);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (39, 39, 'White', 35);
	insert into BodyMeasurements (BMID, SpecimenID, MeasurementType, Measurement) values (40, 40, 'Guamanian', 17);
SET IDENTITY_INSERT BodyMeasurements OFF
GO

SET IDENTITY_INSERT Exhibits ON
	insert into Exhibits (ExhibitID, ExhibitName) values (1, 'Haitian Creole');
	insert into Exhibits (ExhibitID, ExhibitName) values (2, 'Macedonian');
	insert into Exhibits (ExhibitID, ExhibitName) values (3, 'Belarusian');
	insert into Exhibits (ExhibitID, ExhibitName) values (4, 'Persian');
	insert into Exhibits (ExhibitID, ExhibitName) values (5, 'Telugu');
	insert into Exhibits (ExhibitID, ExhibitName) values (6, 'Maltese');
	insert into Exhibits (ExhibitID, ExhibitName) values (7, 'Filipino');
	insert into Exhibits (ExhibitID, ExhibitName) values (8, 'Oriya');
	insert into Exhibits (ExhibitID, ExhibitName) values (9, 'Polish');
	insert into Exhibits (ExhibitID, ExhibitName) values (10, 'Bulgarian');
	insert into Exhibits (ExhibitID, ExhibitName) values (11, 'Afrikaans');
	insert into Exhibits (ExhibitID, ExhibitName) values (12, 'Mongolian');
	insert into Exhibits (ExhibitID, ExhibitName) values (13, 'Punjabi');
	insert into Exhibits (ExhibitID, ExhibitName) values (14, 'Bislama');
	insert into Exhibits (ExhibitID, ExhibitName) values (15, 'Greek');
SET IDENTITY_INSERT Exhibits OFF
GO

SET IDENTITY_INSERT SpeciesAndExhibits ON
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (1, 5);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (6, 5);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (12, 10);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (20, 11);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (5, 14);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (6, 9);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (10, 2);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (13, 14);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (11, 3);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (2, 4);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (15, 9);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (5, 8);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (13, 1);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (6, 15);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (7, 11);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (16, 1);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (1, 10);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (14, 1);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (9, 3);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (2, 9);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (15, 7);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (5, 13);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (3, 5);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (2, 3);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (16, 14);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (9, 10);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (11, 12);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (16, 6);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (8, 11);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (5, 9);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (4, 10);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (16, 7);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (18, 2);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (1, 11);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (11, 12);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (8, 14);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (20, 12);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (13, 6);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (6, 15);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (18, 4);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (7, 15);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (10, 12);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (5, 11);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (10, 14);
	insert into SpeciesAndExhibits (SpeciesID, ExhibitID) values (1, 3);
SET IDENTITY_INSERT SpeciesAndExhibits OFF
GO

SET IDENTITY_INSERT SpeciesAndCommonNames ON
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 16);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (8, 10);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (19, 16);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (1, 13);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 21);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (4, 11);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 26);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (9, 15);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (8, 26);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (4, 22);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (5, 11);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (15, 12);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 24);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (9, 11);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 25);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (16, 25);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (9, 28);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (4, 21);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (17, 8);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (5, 26);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (6, 13);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 15);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (1, 5);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (3, 10);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (12, 19);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (12, 5);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 24);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (12, 8);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (7, 23);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (11, 28);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (1, 10);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 6);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (6, 18);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (4, 14);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (3, 30);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (8, 24);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (8, 1);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (18, 27);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (6, 8);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 1);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 13);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (20, 26);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (2, 9);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (17, 13);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 12);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (18, 3);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (1, 21);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (16, 8);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (9, 2);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (15, 13);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 5);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 26);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 22);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (5, 30);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (15, 29);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 10);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (13, 30);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (8, 5);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (9, 20);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (5, 6);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (16, 5);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (10, 3);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (14, 10);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (16, 19);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (15, 30);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (17, 5);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (19, 13);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (9, 21);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (15, 26);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (17, 25);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (6, 20);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (19, 9);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (8, 19);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (7, 7);
	insert into SpeciesAndCommonNames (SpeciesID, CommonNameID) values (18, 20);
SET IDENTITY_INSERT SpeciesAndCommonNames OFF
GO

SET IDENTITY_INSERT SpeciesMedia ON
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (1, 12, 'erat', 'jgrady0@state.tx.us', 1, 'Toad', 36, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (2, 3, 'ultrices', 'lgrinaugh1@jiathis.com', 1, 'Governmental Affairs', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (3, 5, 'phasellus', 'btumulty2@gmpg.org', 0, 'Dump Truck', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (4, 17, 'dui', 'pyashin3@reference.com', 1, 'Estate Administration', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (5, 10, 'pede', 'thold4@smh.com.au', 1, 'Architectural Illustration', 7, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (6, 11, 'natoque', 'tworkman5@ihg.com', 0, 'Software Testing Life Cycle', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (7, 6, 'sit', 'kabramowitch6@japanpost.jp', 0, 'WMS Implementations', 30, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (8, 3, 'amet', 'wmazzeo7@pen.io', 1, 'FTSE 100', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (9, 13, 'vestibulum', 'ssnufflebottom8@etsy.com', 0, 'Yahoo Search', 8, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (10, 14, 'consectetuer', 'vkeoghan9@vinaora.com', 0, 'Kernel Programming', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (11, 5, 'quis', 'bmcallistera@xrea.com', 0, 'EEO', 31, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (12, 19, 'magna', 'tflattmanb@theatlantic.com', 1, 'Musical Theatre', null, 34);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (13, 20, 'a', 'rpettkoc@fotki.com', 0, 'Foreign Languages', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (14, 9, 'est', 'btaylerd@hc360.com', 1, 'CPR Certified', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (15, 8, 'in', 'rstealye@lulu.com', 1, 'CPA', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (16, 16, 'libero', 'jmarvellf@cargocollective.com', 0, 'XFOIL', null, 13);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (17, 19, 'nulla', 'breckeg@chron.com', 0, 'Mobile Games', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (18, 11, 'parturient', 'gmatiash@facebook.com', 0, 'Ultrasonic Welding', 24, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (19, 18, 'pellentesque', 'dhardsoni@cnbc.com', 0, 'Crystal Reports', 16, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (20, 19, 'nec', 'smchirriej@marriott.com', 0, 'JTAPI', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (21, 14, 'nunc', 'mliebermannk@storify.com', 1, 'European Affairs', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (22, 2, 'nec', 'hcovingtonl@1688.com', 1, 'Bootstrap', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (23, 3, 'vivamus', 'pmourgem@army.mil', 1, 'WAN', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (24, 17, 'eu', 'cporchn@prlog.org', 0, 'Ion Chromatography', null, 55);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (25, 17, 'duis', 'elamorto@vimeo.com', 0, 'Breaking News', null, 54);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (26, 1, 'nulla', 'aragdalep@wp.com', 0, 'GFI', 10, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (27, 18, 'nam', 'binsealq@a8.net', 1, 'Btrieve', null, 43);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (28, 11, 'maecenas', 'lquinnellyr@arstechnica.com', 1, 'IVA', 7, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (29, 16, 'molestie', 'mexells@sun.com', 1, 'Customer Experience', 1, 12);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (30, 19, 'in', 'lbowerbankt@pen.io', 0, 'PTT', 3, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (31, 4, 'mi', 'ncullenu@prnewswire.com', 0, 'Print On Demand', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (32, 19, 'lectus', 'mkingabyv@toplist.cz', 1, 'MPower', 34, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (33, 11, 'et', 'badeyw@apache.org', 0, 'IED', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (34, 11, 'erat', 'bpatullox@cnet.com', 1, 'UFC', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (35, 3, 'lectus', 'fendicotty@japanpost.jp', 0, 'Turbomachinery', 26, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (36, 4, 'quisque', 'dmckendryz@github.com', 1, 'Cerner', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (37, 3, 'mi', 'dbramich10@wufoo.com', 0, 'Cytology', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (38, 11, 'donec', 'lmckeveney11@naver.com', 0, 'iPhone', 2, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (39, 12, 'pretium', 'bgerrill12@surveymonkey.com', 1, 'Group Policy', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (40, 14, 'sed', 'kbaggett13@earthlink.net', 1, 'DDR', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (41, 12, 'quis', 'mbroke14@senate.gov', 0, 'Drug Development', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (42, 18, 'in', 'keck15@about.com', 0, 'Core FTP', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (43, 3, 'orci', 'bseegar16@elegantthemes.com', 1, 'FCL', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (44, 2, 'ac', 'greven17@mysql.com', 0, 'ML', 4, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (45, 2, 'eu', 'dattenburrow18@skyrock.com', 0, 'Construction Safety', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (46, 3, 'lacinia', 'pthurlbourne19@so-net.ne.jp', 0, 'HDX', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (47, 13, 'venenatis', 'mhanks1a@tamu.edu', 0, 'ISO 14971', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (48, 13, 'ligula', 'cmclewd1b@nbcnews.com', 1, 'ASP.NET', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (49, 8, 'at', 'dmagauran1c@loc.gov', 1, 'Electric Utility', 33, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (50, 15, 'enim', 'rproby1d@ed.gov', 1, 'Image Editing', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (51, 9, 'suspendisse', 'miltchev1e@businessweek.com', 1, 'Qooxdoo', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (52, 14, 'condimentum', 'afetherby1f@icio.us', 0, 'Case Management', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (53, 3, 'vestibulum', 'cbance1g@icio.us', 0, 'DC Power', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (54, 6, 'mollis', 'saskem1h@gmpg.org', 1, 'Hypermesh', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (55, 19, 'lobortis', 'astrasse1i@bravesites.com', 0, 'HMRC enquiries', 20, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (56, 10, 'nullam', 'aheselwood1j@shareasale.com', 0, 'IEEE', 36, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (57, 16, 'elementum', 'probillart1k@hud.gov', 0, 'UV', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (58, 6, 'luctus', 'rgreiswood1l@cbsnews.com', 1, 'Development Economics', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (59, 2, 'gravida', 'smerrett1m@deliciousdays.com', 1, 'QMF', 13, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (60, 3, 'donec', 'mseefus1n@ftc.gov', 1, 'Gift Cards', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (61, 9, 'justo', 'lwhatley1o@deliciousdays.com', 1, 'Urban Search &amp; Rescue', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (62, 11, 'nullam', 'ydesorts1p@shinystat.com', 0, 'SAP EWM', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (63, 1, 'leo', 'cettritch1q@seesaa.net', 1, 'ERDAS Imagine', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (64, 18, 'vestibulum', 'smordacai1r@studiopress.com', 1, 'Receptionist Duties', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (65, 9, 'semper', 'uhabbema1s@weebly.com', 0, 'RDO', null, 6);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (66, 1, 'pede', 'dduffyn1t@baidu.com', 1, 'PJM', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (67, 7, 'ut', 'cpym1u@gizmodo.com', 0, 'MTA', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (68, 14, 'in', 'sgameson1v@nba.com', 0, 'Marketing Communications', 19, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (69, 11, 'cras', 'esmorthwaite1w@edublogs.org', 0, 'Sleepwear', null, 15);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (70, 20, 'mauris', 'ohiskey1x@dagondesign.com', 0, 'QMF for Windows', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (71, 19, 'ut', 'sgear1y@time.com', 0, 'DBVisualizer', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (72, 18, 'blandit', 'alowden1z@hexun.com', 0, 'CVIS', 13, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (73, 7, 'velit', 'hcicchillo20@utexas.edu', 0, 'Aeronautics', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (74, 12, 'vestibulum', 'mradley21@vinaora.com', 0, 'Small Business Marketing', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (75, 14, 'maecenas', 'nminker22@nyu.edu', 0, 'Umbrellas', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (76, 2, 'ultrices', 'kblazej23@baidu.com', 1, 'Solid Oxide Fuel Cells', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (77, 16, 'nulla', 'plindenstrauss24@cbsnews.com', 0, 'LDD', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (78, 16, 'lacus', 'llandon25@house.gov', 1, 'GIMP', 20, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (79, 15, 'pede', 'tjanisson26@prlog.org', 1, 'FCIP', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (80, 19, 'nunc', 'jkellart27@usda.gov', 1, 'Architectural Design', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (81, 7, 'convallis', 'smaynard28@paginegialle.it', 0, 'Waxing', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (82, 2, 'massa', 'cjakoub29@pcworld.com', 1, 'Oil Sands', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (83, 1, 'vel', 'aemery2a@netscape.com', 0, 'MVPN', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (84, 3, 'sed', 'smarchment2b@deliciousdays.com', 1, 'iBatis', null, 36);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (85, 6, 'donec', 'lstartin2c@liveinternet.ru', 0, 'VLR', 3, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (86, 14, 'a', 'scolbert2d@blog.com', 1, 'Early-stage Startups', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (87, 3, 'nulla', 'wdebrett2e@goo.ne.jp', 0, 'Smartboard', 39, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (88, 5, 'sollicitudin', 'dwinspire2f@noaa.gov', 1, 'ISTQB', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (89, 11, 'vivamus', 'eeger2g@vinaora.com', 1, 'eEye Retina', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (90, 5, 'ut', 'cwrankling2h@flickr.com', 1, 'AFM', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (91, 12, 'amet', 'wkeune2i@disqus.com', 0, 'HP Storage', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (92, 15, 'pellentesque', 'hbailes2j@omniture.com', 1, 'Leave of Absence', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (93, 17, 'leo', 'nmanhood2k@psu.edu', 1, 'DFP', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (94, 6, 'suspendisse', 'lbaniard2l@google.it', 1, 'XFire', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (95, 6, 'nunc', 'lcarmel2m@google.es', 0, 'DCP', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (96, 18, 'aliquet', 'hayliff2n@alibaba.com', 1, 'DFS', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (97, 2, 'nisi', 'mbrumwell2o@ibm.com', 1, 'mTAB', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (98, 12, 'bibendum', 'jcrowne2p@vistaprint.com', 0, '21 CFR', null, null);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (99, 3, 'sollicitudin', 'avanichev2q@timesonline.co.uk', 1, 'Military Experience', null, 8);
	insert into SpeciesMedia (SpeciesMediaID, SpeciesID, MediaType, [MediaURL], IsProtected, FriendlyName, SpecimenID, PartTypeID) values (100, 2, 'habitasse', 'jdepietri2r@g.co', 1, 'MDL', null, null);
SET IDENTITY_INSERT SpeciesMedia OFF
GO


USE master
GO

ALTER DATABASE JJABY SET READ_WRITE
GO