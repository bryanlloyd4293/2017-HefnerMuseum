--EXAMPLE CHANGE!!!!

USE master
GO


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
	State			VARCHAR(100)							NULL,
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
	AccessionNumber	INT										NOT NULL,
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
	[URL]					varchar(1000)							NOT NULL,
	IsProtected			BIT										NOT NULL,
	FriendlyName		varchar(100)							NOT NULL,
	SpecimenID			INT		REFERENCES	Specimen(SpecimenID)	NULL,
	PartTypeID			INT		REFERENCES	PartType(PartTypeID)	NULL
)


