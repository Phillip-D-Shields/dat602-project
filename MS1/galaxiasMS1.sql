drop database if exists galaxias;
create database galaxias;
use galaxias;
drop procedure if exists galaxiasDDL;
drop procedure if exists galaxiasDML;
delimiter //

-- create procedure ======================================================

create procedure galaxiasDDL()
begin
create table tblPilot(
	PilotID int not null auto_increment primary key,
    PilotName varchar(30) not null unique,
    PilotPassword varchar(20) not null,
	Email varchar(50) not null,
    LoginAttempts int not null,
    PilotLocked bool not null,
    PilotOnline bool not null,
    Administrator bool not null,
    TotalScore int not null 
    );
create table tblExplore(
	ExploreID int not null auto_increment primary key,
    ExploreName varchar(50) not null,
    MaxPilots int not null,
    ActivePilots int,
    ExploreStatus bool
    );
create table tblExploreGalaxy(
	GalaxyID int not null auto_increment primary key,
    ExploreID int not null,
    rowsMax int not null,
    colsMax int not null,
    foreign key (ExploreID) references tblExplore(ExploreID)
    );
create table tblExploreGalaxyVector(
	VectorID int not null auto_increment primary key,
    GalaxyID int not null,
    xPosition int not null,
    yPosition int not null,
    VectorActive bool,
    foreign key (GalaxyID) references tblExploreGalaxy(GalaxyID)
    );
create table tblElement(
	ElementID int not null auto_increment primary key,
    ElementName varchar(30) not null,
    ElementDescription varchar(50) not null,
    ElementValue int not null
    );
create table tblExploreVectorElement(
	VectorElementID int not null auto_increment primary key,
	VectorID int not null,
    ElementID int not null,
    foreign key (VectorID) references tblExploreGalaxyVector(VectorID),
    foreign key (ElementID) references tblElement(ElementID)
    );
create table tblExplorePlay(
	ExplorePlayID int not null auto_increment primary key,
    PilotID int not null,
    VectorID int,
    ExploreID int,
    PilotNumber int,
    foreign key (PilotID) references tblPilot(PilotID),
    foreign key (VectorID) references tblExploreGalaxyVector(VectorID),
    foreign key (ExploreID) references tblExplore(ExploreID)
    );
create table tblExplorePlayStock(
	StockID int not null auto_increment primary key,
    ExplorePlayID int not null,
    ElementID int,
    Quantity int,
    foreign key (ExplorePlayID) references tblExplorePlay(ExplorePlayID),
    foreign key (ElementID) references tblElement(ElementID)
    );
create table tblExploreScore(
	ScoreID int not null auto_increment primary key,
    CurrentExploreScore int,
    ExplorePlayID int not null,
    ExploreID int not null,
    foreign key (ExplorePlayID) references tblExplorePlay(ExplorePlayID),
    foreign key (ExploreID) references tblExplore(ExploreID)
    );
end //
delimiter ;

delimiter //
create procedure galaxiasDML()
begin
-- insert statements ===========================================================
insert into tblPilot (PilotName, PilotPassword, Email, LoginAttempts, PilotLocked, PilotOnline, Administrator, TotalScore)
	values 
    ('phill', '1234', 'phill@phill.com', '0', '0', '0', '1', '10000'),
    ('jeff', '1234', 'jeff@phill.com', '0', '0', '0', '1', '0'),
    ('cronus', '1234', 'cronus@phill.com', '5', '1', '0', '0', '124'),
    ('god', '1234', 'god@phill.com', '0', '0', '0', '0', '69');
insert into tblElement (ElementName, ElementDescription, ElementValue)
	values
    ('gold', 'shiney', '100'),
    ('ether', 'mysterious', '500'),
    ('floatoidium', 'anti gravity', '500'),
    ('eskiem', 'smells funky', '50'),
    ('black quarks', 'painful', '-50'),
    ('black hole', 'get rekt', '-5000');
insert into tblExplore (ExploreName, MaxPilots, ActivePilots, ExploreStatus)
	values
    ('phills explore', '4', '1', '1'),
    ('jeebus explore', '4', '1', '1');
insert into tblExploreGalaxy (ExploreID, rowsMax, colsMax)
	values
    ('1', '10', '10'),
    ('2', '10', '10');
insert into tblExploreGalaxyVector (GalaxyID, xPosition, yPosition, VectorActive)
	values
    ('1', '0', '0', true), ('1', '0', '1', true), ('1', '0', '2', true), ('1', '0', '3', true), ('1', '0', '4', true), ('1', '0', '5', true), ('1', '0', '6', true), ('1', '0', '7', true), ('1', '0', '8', true), ('1', '0', '9', true), ('1', '0', '10', true),
    ('1', '1', '0', true), ('1', '1', '1', true), ('1', '1', '2', true), ('1', '1', '3', true), ('1', '1', '4', true), ('1', '1', '5', true), ('1', '1', '6', true), ('1', '1', '7', true), ('1', '1', '8', true), ('1', '1', '9', true), ('1', '1', '10', true),
    ('1', '2', '0', true), ('1', '2', '1', true), ('1', '2', '2', true), ('1', '2', '3', true), ('1', '2', '4', true), ('1', '2', '5', true), ('1', '2', '6', true), ('1', '2', '7', true), ('1', '2', '8', true), ('1', '2', '9', true), ('1', '2', '10', true); 
insert into tblExploreVectorElement (VectorID, ElementID)
	values
    ('1', '1'), ('3', '1'), ('4', '1'), ('11', '1'), ('13', '1'), ('14', '1'), ('16', '2'), ('19', '3'), ('21', '4'), ('24', '5'), ('25', '6'), ('31', '1');
insert into tblExplorePlay (PilotID, VectorID, ExploreID, PilotNumber)
	values
    ('2', '1', '1', '1'),
    ('3', '1', '2', '1');
insert into tblExplorePlayStock (ExplorePlayID, ElementID, Quantity)
	values
    ('1', null, 0),
    ('2', null, 0);
insert into tblExploreScore (ExploreID, ExplorePlayID, CurrentExploreScore)
	values
    ('1', '1', '0'),
    ('2', '2', '0');
-- selects ==========================================================================
-- list accounts that are locked
select 
	PilotID, PilotName
	from tblPilot
    where PilotLocked = true;
-- show elements that lose players points
select 
	ElementName, ElementValue
    from tblElement
    where ElementValue <0;
-- show games currently in progress    
select 
	ExploreID, ExploreName
    from tblExplore
    where ExploreStatus = true;
-- show games with players still on home Vector    
select 
	ExplorePlayID, PilotID, ExploreID
    from tblExplorePlay
    where VectorID = 1;
-- show total elements already collected in a game    
select sum(distinct Quantity) as TotalElementsCurrentlyAttained 
	from tblExplorePlayStock
    where ExplorePlayID = 1;
-- show galaxies in database    
select count(*) as NumberOfExploreGalaxys  
    from tblExploreGalaxy;
-- show vectors currently in play    
select
	VectorID, xPosition as rowNumber, yPosition as columnNumber
	from tblExploreGalaxyVector
    where VectorActive = true;
-- counts Vector with gold
select count(*) as NumberOfVectorsWithGold 
	from tblExploreVectorElement
    where ElementID = 1;
-- show top ten current game scores
select 
	ExploreID, ExplorePlayID, CurrentExploreScore
    from tblExploreScore
    Order by CurrentExploreScore
    Limit 10;
-- updates ==============================================================
-- admin unlock pilot
update tblPilot
	set tblPilot.PilotLocked = false, tblPilot.LoginAttempts = 0
	where tblPilot.PilotID = 3;
-- update value of gold
update tblElement 
	set tblElement.ElementValue = 200
    where tblElement.ElementID = 1;
-- change game status to offline
update tblExplore 
	set tblExplore.ExploreStatus = false
    where ExploreID = 2;
-- increase galaxy size
update tblExploreGalaxy 
	set tblExploreGalaxy.rowsMax = 10, tblExploreGalaxy.colsMax = 10
    where tblExploreGalaxy.ExploreID = 2;
-- disable a vector
update tblExploreGalaxyVector 
	set tblExploreGalaxyVector.VectorActive = false
    where tblExploreGalaxyVector.VectorID = 2;
-- add item to stock
update tblExplorePlayStock 
	set tblExplorePlayStock.ElementID = 1, tblExplorePlayStock.Quantity = Quantity+1
    where tblExplorePlayStock.StockID = 1;
-- add stock to game score
update tblExploreScore, tblExplorePlayStock, tblElement 
	set tblExploreScore.CurrentExploreScore = CurrentExploreScore+(tblExplorePlayStock.Quantity*tblElement.ElementValue)
    where tblExploreScore.ScoreID = 1
    and tblExplorePlayStock.StockID = 1;
-- change element on a vector
update tblExploreVectorElement 
	set tblExploreVectorElement.ElementID = 3
    where tblExploreVectorElement.VectorID = 11;
-- player moves vector
update tblExplorePlay 
	set tblExplorePlay.VectorID = 2
    where tblExplorePlay.ExplorePlayID = 1;
-- delete statments ===============================================
-- this is intentionally commented out so that results can be seen
-- uncomment to delete stuff
-- delete from tblExploreScore;
-- delete from tblExplorePlayStock;
-- delete from tblExplorePlay;
-- delete from tblExploreVectorElement;
-- delete from tblExploreGalaxyVector;
-- delete from tblExploreGalaxy;
-- delete from tblExplore;
-- delete from tblElement;
-- delete from tblPilot;
end //
delimiter ;

call galaxiasDDL();
call galaxiasDML();