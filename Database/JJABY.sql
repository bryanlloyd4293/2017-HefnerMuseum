USE master
GO

DROP DATABASE JJABY
GO

CREATE DATABASE JJABY
GO 

USE JJABY
GO

CREATE TABLE Taxonomy(
	TaxonomyID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	Domain			VARCHAR(20)							NOT NULL,
	Kingdom			VARCHAR(20)							NOT NULL,
	Phylum			VARCHAR(20)							NOT NULL,
	Class			VARCHAR(20)							NOT NULL,
	[Order]			VARCHAR(20)							NOT NULL,
	Family			VARCHAR(20)							NOT NULL,
	Genus			VARCHAR(20)							NOT NULL,
	Species			VARCHAR(20)							NOT NULL,
	SubSpecies		VARCHAR(20)							NOT NULL
)

CREATE TABLE CommonName(
	CommonNameID	INT		PRIMARY KEY		IDENTITY	NOT NULL,
	CommonNameName	VARCHAR(20)							NOT NULL
)

CREATE TABLE Room(
	RoomID			INT		PRIMARY KEY		IDENTITY	NOT NULL,
	RoomName		VARCHAR(20)							NOT NULL
)

CREATE TABLE Section(
	SectionID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	RoomID			INT		REFERENCES Room(RoomID)		NOT NULL,
	SectionName		VARCHAR(20)							NOT NULL
)

CREATE TABLE Species(
	SpeciesID		INT		PRIMARY KEY		IDENTITY			NOT NULL,
	TaxonomyID		INT		REFERENCES Taxonomy(TaxonomyID)		NOT NULL,
	Details			XML		DEFAULT('<Population></Population><><><><><><><><><><><><>')									NOT NULL,
	[Population]	VARCHAR(max)								NOT NULL,
	[Range]			VARCHAR(max)								NOT NULL,
	Threat			VARCHAR(max)								NOT NULL,
	Uses			VARCHAR(max)								NOT NULL,
	Ecology			VARCHAR(max)								NOT NULL,
	Habitat			VARCHAR(max)								NOT NULL,
	Size			VARCHAR(max)								NOT NULL,
	Lifespan		VARCHAR(max)								NOT NULL,
)

CREATE TABLE Specimen(
	SpecimenID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID		INT		REFERENCES Species(SpeciesID)	NOT NULL,
	SectionID		INT		REFERENCES Section(SectionID)	NOT NULL,
	Sex				VARCHAR(1)								NOT NULL,
	Age				VARCHAR(20)								NOT NULL,
	ArchiveNumber	INT										NOT NULL,
	[Weight]		VARCHAR(20)								NOT NULL,
	[Length]		VARCHAR(20)								NOT NULL,
	--Other Measurements??
	IdentifiedBy	VARCHAR(30)								NOT NULL,
	NatureOfIdentification		VARCHAR(30)					NOT NULL,	--Check with Steve
	CollectedBy		VARCHAR(30)								NOT NULL,
	PresentedBy		VARCHAR(30)								NOT NULL,
	PreparedBy		VARCHAR(30)								NOT NULL,
	Locality		VARCHAR(30)								NOT NULL,
	CollectingSource	VARCHAR(20)							NOT NULL,
	EventDate		DATE									NOT NULL,
	VerificationStatus	VARCHAR(20)							NOT NULL,
	Coordinates		VARCHAR(30)								NOT NULL,
	PartTypes		VARCHAR(30)								NOT NULL,	--dafuq
	Remarks			VARCHAR(40)								NOT NULL
)

CREATE TABLE Exhibit(
	ExhibitID		INT		PRIMARY KEY		IDENTITY	NOT NULL,
	ExhibitName		VARCHAR(20)							NOT NULL
)

CREATE TABLE Images(
	ImagesID			INT		PRIMARY KEY		IDENTITY		NOT NULL,
	ImageFileName		VARCHAR(500)							NOT NULL,		--Probably not a VARCHAR
	ImageResolution		VARCHAR(20)								NOT NULL,		--Also probably not a VARCHAR
	ResolutionHeight	INT										NOT NULL,
	ResolutionWidth		INT										NOT NULL
)

CREATE TABLE AudioFiles(
	AudioFilesID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	AudioFileName		VARCHAR(30)									NOT NULL
)

CREATE TABLE VideoFiles(
	VideoFilesID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	VideoURL			VARCHAR(30)									NOT NULL
)

CREATE TABLE SpeciesAndCommonNames(
	SpeciesID				INT		REFERENCES Species(SpeciesID)		NOT NULL,
	CommonNameID			INT		REFERENCES CommonName(CommonNameID)	NOT NULL,
	PRIMARY KEY (SpeciesID, CommonNameID)
)

CREATE TABLE SpeciesImages(
	SpeciesImagesID		INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID			INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	ImageURL			varchar(100)							NOT NULL,
	FriendlyName		varchar(100)							NOT NULL
)

CREATE TABLE AudioFilesAndImages(
	SpeciesAndAudioFilesID	INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID				INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	AudioFilesID			INT		REFERENCES	AudioFiles(AudioFilesID)	NOT NULL
)

CREATE TABLE VideoFilesAndImages(
	SpeciesAndVideoFilesID	INT		PRIMARY KEY		IDENTITY		NOT NULL,
	SpeciesID				INT		REFERENCES	Species(SpeciesID)	NOT NULL,
	VideoFilesID			INT		REFERENCES	VideoFiles(VideoFilesID)	NOT NULL
)

