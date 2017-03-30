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

	/***** TABLE Common Names *****//
CREATE TABLE CommonName(
	CommonNameID	INT		PRIMARY KEY		IDENTITY	NOT NULL,
	CommonNameName	VARCHAR(20)							NOT NULL
)
GO

	/***** TABLE Species Location: Room *****/
CREATE TABLE Room(
	RoomID			INT		PRIMARY KEY		IDENTITY	NOT NULL,
	RoomName		VARCHAR(20)							NOT NULL
)
GO

	/***** TABLE Species Location: Section *****/
CREATE TABLE Section(
	SectionID		INT		PRIMARY KEY		IDENTITY	NOT NULL, --LOOK AT RENAMING
	RoomID			INT		REFERENCES Room(RoomID)		NOT NULL,
	SectionName		VARCHAR(20)							NOT NULL
)
GO

	/***** TABLE Species *****/
CREATE TABLE Species(
	SpeciesID		INT		PRIMARY KEY		IDENTITY			NOT NULL,
	TaxonomyID		INT		REFERENCES Taxonomy(TaxonomyID)		NOT NULL,
	Details			XML		DEFAULT('<Population></Population>
									<Range></Range>
									<Threat></Threat>
									<Uses></Uses>
									<Ecology></Ecology>
									<Habitat></Habitat>
									<Size></Size>
									<Lifespan></Lifespan>')		NOT NULL
)
GO

	/***** TABLE Specimen *****/
CREATE TABLE Specimen(
	SpecimenID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID		INT		REFERENCES Species(SpeciesID)	NOT NULL,  -- default ?
	SectionID		INT		REFERENCES Section(SectionID)	NOT NULL,  --ROOM  CABINET  DRAWER  Look at Section comment for info
	Sex				VARCHAR(1)								NULL,
	Age				VARCHAR(20)								NULL,
	ArchiveNumber	INT										NOT NULL, -- Accession number is new primary key
	[Weight]		VARCHAR(20)								NULL,  -- grams. number data type.
	[Length]		VARCHAR(20)								NULL,  -- length is different for different species. maybe body measurement is own table
	--Other Measurements??
	IdentifiedBy	VARCHAR(30)								NOT NULL,
	NatureOfIdentification		VARCHAR(30)					NOT NULL,	
	CollectedBy		VARCHAR(30)								NOT NULL, -- collected date field
	PresentedBy		VARCHAR(30)								NULL, -- presented date field
	PreparedBy		VARCHAR(30)								NULL, -- prepared date field
	Locality		VARCHAR(30)								NOT NULL,  -- Break up by country, state, county, township, city, description. partial null in this table
	CollectingSource	VARCHAR(20)							NOT NULL,
	EventDate		DATE									NOT NULL, -- Record date record created. Record name of individual recording data. 2 fields.
	VerificationStatus	VARCHAR(20)							NULL,
	Coordinates		VARCHAR(30)								NULL, -- How to store this (data type). gps coordinates
	PartTypes		VARCHAR(30)								NOT NULL, -- each animal has its own part types. part type table? partial nulls in table
	Remarks			VARCHAR(500)							NULL
)
GO

	/***** TABLE Exhibits *****/
CREATE TABLE Exhibits(
	ExhibitID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	ExhibitName		VARCHAR(20)							NOT NULL
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

	/***** TABLE Species' Images *****/
CREATE TABLE SpeciesImages(
	SpeciesImagesID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID			INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	ImageURL			varchar(100)							NOT NULL,
	FriendlyName		varchar(100)							NOT NULL
)
GO

	/***** TABLE Species' Audio *****/
CREATE TABLE SpeciesAudio(
	SpeciesAudioID			INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID				INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	AudioURL				varchar(100)							NOT NULL,
	FriendlyName			varchar(100)							NOT NULL
)
GO

	/***** TABLE Species' Video *****/
CREATE TABLE SpeciesVideo(
	SpeciesVideoID	INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID				INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	VideoURL				varchar(100)							NOT NULL,
	FriendlyName			varchar(100)							NOT NULL
)
GO

INSERT Taxonomy (Domain, Kingdom, Phylum, Class, [Order], Family, Genus, Species, SubSpecies) VALUES
	('Animalia', 'Chordata', 'Mammalia', 'Carnivora', 'Mustelidae', 'Mustelinae', 'Mustela', 'nivalis', 'allegheniensis')

INSERT CommonName (CommonNameName) VALUES
	('Least Weasel')

INSERT Species (Details) VALUES
	('')

INSERT Specimen (Sex, Age, ArchiveNumber, [Weight], [Length], IdentifiedBy, NatureOfIdentification, CollectedBy, PresentedBy, PreparedBy, Locality, CollectingSource, EventDate, VerificationStatus, Coordinates, PartTypes, Remarks) VALUES
	('F', 'Mature', '2017.01.02.1a', '', '', 'S. Sullivan', 'Nelson Hofster', 'Jane Holster', 'William J. Hamilton', 'Former soy and corn field', 'wild caught', CAST('2017-01-20 00:00:00' AS SmallDateTime), 'verified', '40.889568/ -81.597623', '', 'killed by house cat')