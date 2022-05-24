drop database if exists Galaxias;

create database Galaxias;

use Galaxias;

drop procedure if exists ddlGalaxiasDB;

delimiter //

create procedure ddlGalaxiasDB()
begin

    create table tblPilot
    (
        PilotID       int         not null auto_increment primary key,
        PilotName     varchar(30) not null unique,
        PilotPassword varchar(20) not null,
        Email         varchar(50) not null,
        LoginAttempts int         not null,
        PilotLocked   bool        not null,
        PilotOnline   bool        not null,
        Administrator bool        not null,
        TotalScore    int         not null
    );

    CREATE TABLE tblGalaxy
    (
        GalaxyID     INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
        GalaxyName   VARCHAR(50) NOT NULL,
        maxPilots    INT         NOT NULL,
        ActivePilots INT,
        GalaxyStatus BOOL
    );

    CREATE TABLE tblMap
    (
        MapID    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        GalaxyID INT NOT NULL,
        xMax     INT NOT NULL,
        yMax     INT NOT NULL,
        FOREIGN KEY (GalaxyID)
            REFERENCES tblGalaxy (GalaxyID)
            ON DELETE CASCADE
    );

    CREATE TABLE tblVector
    (
        VectorID     INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        MapID        INT NOT NULL,
        xPosition    INT NOT NULL,
        yPosition    INT NOT NULL,
        VectorActive BOOL,
        FOREIGN KEY (MapID)
            REFERENCES tblMap (MapID)
            ON DELETE CASCADE
    );

    CREATE TABLE tblElement
    (
        ElementID          INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
        ElementName        VARCHAR(30) NOT NULL,
        ElementDescription VARCHAR(50) NOT NULL,
        ElementValue       INT         NOT NULL
    );

    CREATE TABLE tblVectorElement
    (
        VectorElementID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        VectorID        INT NOT NULL,
        ElementID       INT NOT NULL,
        FOREIGN KEY (VectorID)
            REFERENCES tblVector (VectorID)
            ON DELETE CASCADE,
        FOREIGN KEY (ElementID)
            REFERENCES tblElement (ElementID)
    );

    CREATE TABLE tblSession
    (
        SessionID     INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
        PilotID       INT  NOT NULL,
        MapID         INT,
        VectorID      INT,
        GalaxyID      INT,
        PilotNumber   INT,
        Score         INT,
        SessionActive BOOL NOT NULL,
        FOREIGN KEY (PilotID)
            REFERENCES tblPilot (PilotID)
            ON DELETE CASCADE,
        FOREIGN KEY (MapID)
            REFERENCES tblMap (MapID)
            ON DELETE CASCADE,
        FOREIGN KEY (VectorID)
            REFERENCES tblVector (VectorID),
        FOREIGN KEY (GalaxyID)
            REFERENCES tblGalaxy (GalaxyID)
    );


    CREATE TABLE tblInventory
    (
        InventoryID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        PilotID     INT NOT NULL,
        SessionID   INT NOT NULL,
        ElementID   INT,
        Quantity    INT,
        FOREIGN KEY (PilotID)
            REFERENCES tblPilot (PilotID)
            ON DELETE CASCADE,
        FOREIGN KEY (SessionID)
            REFERENCES tblSession (SessionID)
            ON DELETE CASCADE,
        FOREIGN KEY (ElementID)
            REFERENCES tblElement (ElementID)
    );

end //
delimiter ;

drop procedure if exists dmlGalaxiasDB;

delimiter //
create procedure dmlGalaxiasDB()
begin
    insert into tblElement (ElementName, ElementDescription, ElementValue)
    values ('gold', 'shiny shiny', '10'),
           ('ether', 'mysterious power', '50'),
           ('float gem', 'floaty floaty', '100'),
           ('vibranium', 'all powerful', '500'),
           ('void energy', 'voidy voidy', '-500'),
           ('black hole', 'massive damage', '-500');


    call pilotRegistration('phill', '1234', 'phill@email.com');

    call pilotRegistration('stu', '1234', 'stu@email.com');

    call pilotRegistration('jeebus', '1234', 'jeebus@email.com');

    call pilotRegistration('alex', '1234', 'alex@email.com');

    call pilotRegistration('tina', '1234', 'tina@email.com');

    call pilotRegistration('cpt nope', '1234', 'nope@email.com');

    call pilotRegistration('god', '1234', 'god@email.com');


-- test data modify user
    call adminModify(
            '1',
            'phill',
            '1234',
            'phill@email.com',
            '0',
            false,
            true,
            '10000'
        );

    call adminModify(
            '3',
            'jeebus',
            '1234',
            'jeebus@email.com',
            '0',
            false,
            false,
            '1500'
        );

    call adminModify(
            '2',
            'stu',
            '1234',
            'stu@email.com',
            '0',
            false,
            false,
            '7500'
        );

    call adminModify(
            '4',
            'alex',
            '1234',
            'alex@email.com',
            '0',
            false,
            false,
            '50000'
        );

    call adminModify(
            '7',
            'god',
            '1234',
            'god@email.com',
            '0',
            true,
            true,
            '500000'
        );

-- test data new quest
    call newGalaxy('4', '000004');

    call newGalaxy('3', '000003');

    call newGalaxy('2', '000002');

-- test data join quest
    call joinGalaxy('1', '1');

    call joinGalaxy('3', '1');

    call joinGalaxy('7', '2');

    call joinGalaxy('5', '1');

-- inventory data add for console app demo
    update
        tblInventory
    set Quantity = 10
    where PilotID = 3
      and SessionID = 2
      and ElementID = 1;

    update
        tblInventory
    set Quantity = 1
    where PilotID = 3
      and SessionID = 2
      and ElementID = 2;

    update
        tblInventory
    set Quantity = 2
    where PilotID = 3
      and SessionID = 2
      and ElementID = 3;

    update
        tblInventory
    set Quantity = 1
    where PilotID = 3
      and SessionID = 2
      and ElementID = 4;

end//

delimiter ;

drop procedure if exists pilotRegistration;

delimiter //

create procedure pilotRegistration(
    in pPilotName varchar(30),
    in pPilotPassword varchar(20),
    pEmail varchar(50)
)
begin
    if exists(
            select *
            from tblPilot
            where PilotName = pPilotName
        ) then
        begin
            select 'failed - pilot name exists' as message;

        end;

    else
        insert into tblPilot(PilotName,
                             PilotPassword,
                             Email,
                             LoginAttempts,
                             PilotLocked,
                             PilotOnline,
                             Administrator,
                             TotalScore)
        values (pPilotName, pPilotPassword, pEmail, 0, 0, 0, 0, 0);

        select 'success - pilot added' as message;

    end if;

end//

delimiter ;

drop procedure if exists pilotLogin;

delimiter //

create procedure pilotLogin(
    in pPilotName varchar(30),
    in pPilotPassword varchar(20)
)
begin
    declare verifyPilot int default null;

    if exists(
            select PilotID -- PilotName is existing
            from tblPilot
            where PilotName = pPilotName
        ) then
        begin
            select PilotID
            from tblPilot
            where PilotName = pPilotName
              and PilotPassword = pPilotPassword
            into verifyPilot;

            if verifyPilot is null then -- invalid password                       
                update
                    tblPilot
                set LoginAttempts = LoginAttempts + 1
                where PilotName = pPilotName;

                if (select PilotID -- failed logins less 3
                    from tblPilot
                    where PilotName = pPilotName
                      and LoginAttempts < 3) then
                    select 'bad Password' as message;

                else -- failed logins 3 or more
                    update
                        tblPilot
                    set PilotLocked = true
                    where PilotName = pPilotName;

                    select 'pilot locked - message admin' as message;

                end if;

            else
                if (select PilotID
                    from tblPilot
                    where PilotName = pPilotName
                      and PilotLocked = true) then
                    select 'pilot locked - message admin' as message;

                else
                    update
                        tblPilot
                    set LoginAttempts = 0,
                        PilotOnline   = true
                    where PilotName = pPilotName;

                    select 'success - pilot online' as message;

                end if;

            end if;

        end;

    else
        select 'bad pilot name' as message;

    end if;

end//

delimiter ;

drop procedure if exists pilotLogout;

delimiter //

create procedure pilotLogout(in pPilotID int)
begin
    update
        tblPilot
    set PilotOnline = false
    where PilotID = pPilotID;

    select 'success - pilot offline' as message;

end//

delimiter ;

drop procedure if exists pilotDelete;
delimiter //

create procedure pilotDelete(
    in pPilotName varchar(30),
    in pPilotPassword varchar(20)
)
begin
    declare verifyPilot int default null;

    select PilotID
    from tblPilot
    where PilotName = pPilotName
      and PilotPassword = pPilotPassword
    into verifyPilot;

    if verifyPilot is null then
        select 'bad name or password' as message;

    else
        delete
        from tblPilot
        where PilotName = pPilotName;

        select 'success - pilot deleted' as message;

    end if;

end//

delimiter ;

drop procedure if exists newGalaxy;

delimiter //

create procedure newGalaxy(in pPilotID int, in pGalaxyName varchar(50))
begin

    declare maxPilots int default 6;

    declare activePilots int default 1;

    declare galaxyStatus int default 1;

    declare pilotNumber int default 1;

    declare score int default 0;

    declare newGalaxyID int default null;

    declare newMapID int default null;

    declare homeVectorID int default null;

    declare endVectorID int default null;

    declare rowMin int default 1;

    declare rowMax int default 20;

    declare colMin int default 1;

    declare colMax int default 20;

    declare elementCount int default 0;

    declare elementVector int default null;

    declare elementType int default 1;

    declare newSessionID int default null;

    if exists(
            select GalaxyName
            from tblGalaxy
            where GalaxyName = pGalaxyName
        ) then
        select 'bad galaxy name' as message;

    else
        insert into tblGalaxy(GalaxyName, maxPilots, ActivePilots, GalaxyStatus)
        values (pGalaxyName, maxPilots, ActivePilots, GalaxyStatus);

        set
            newGalaxyID = last_insert_id();

-- map instance
        insert into tblMap(GalaxyID, xMax, yMax)
        values (newGalaxyID, rowMax, colMax);

        set
            newMapID = last_insert_id();

-- map tiles
        vectorRow:
        loop
            vectorCol:
            loop
                insert into tblVector(MapID, xPosition, yPosition, VectorActive)
                values (newMapID, rowMin, colMin, true);

                set
                    colMin = colMin + 1;

                if colMin > 10 then
                    set
                        colMin = 1;

                    leave vectorCol;

                end if;

            end loop vectorCol;

            set
                rowMin = rowMin + 1;

            if rowMin > 10 then
                leave vectorRow;

            end if;

        end loop vectorRow;

-- finds new home VectorID
        select VectorID
        into homeVectorID
        from tblVector
        where xPosition = 1
          and yPosition = 1
          and MapID = newMapID;

-- finds new end VectorID
        select VectorID
        into endVectorID
        from tblVector
        where xPosition = 10
          and yPosition = 10
          and MapID = newMapID;

-- creates all game elements on random vectors
        getElement:
        loop
            addElement:
            loop
                set
                    elementVector = (select floor(rand() * (endVectorID - homeVectorID) + homeVectorID));

                if not exists(
                        select *
                        from tblVectorElement
                        where VectorID = elementVector
                    ) then
                    set
                        elementCount = elementCount + 1;

                    insert into tblVectorElement(VectorID, ElementID)
                    values (elementVector, elementType);

                end if;

                if elementCount = 25 then
                    set
                        elementCount = 0;

                    leave addElement;

                end if;

            end loop addElement;

            set
                elementType = elementType + 1;

            if elementType > 6 then
                set
                    elementType = 1;

                leave getElement;

            end if;

        end loop getElement;


        insert into tblSession(PilotID,
                               GalaxyID,
                               MapID,
                               VectorID,
                               PilotNumber,
                               Score,
                               SessionActive)
        values (pPilotID,
                newGalaxyID,
                newMapID,
                homeVectorID,
                PilotNumber,
                score,
                true);

        set
            newSessionID = last_insert_id();


        while elementType <= 4
            do
                insert into tblInventory(ElementID, PilotID, SessionID, Quantity)
                values (elementType, pPilotID, newSessionID, 0);

                set
                    elementType = elementType + 1;

            end while;

        select 'new galaxy initiated' as message;

    end if;

end//

delimiter ;

drop procedure if exists joinGalaxy;
delimiter //
create procedure joinGalaxy(in pPilotID int, in pGalaxyID int)
begin

    declare currentCount int default null;

    declare maxCount int default null;

    declare pilotNumber int default null;

    declare sessionMapID int default null;

    declare homeVectorID int default null;

    declare score int default 0;

    declare newSessionID int default null;

    declare elementType int default 1;

    declare existingSessionID int default null;

    declare existingVectorID int default null;

    declare onlineCount int default null;

    set
        sessionMapID = (select MapID
                        from tblMap
                        where GalaxyID = pGalaxyID);

    set
        homeVectorID = (select VectorID
                        from tblVector
                        where xPosition = 1
                          and yPosition = 1
                          and MapID = sessionMapID);

    set
        onlineCount = (select count(*)
                       from tblSession
                       where GalaxyID = pGalaxyID
                         and SessionActive = true);

-- new or returning user
    if exists(
            select SessionID
            from tblSession
            where PilotID = pPilotID
              and GalaxyID = pGalaxyID
        ) then
        set
            existingSessionID = (select SessionID
                                 from tblSession
                                 where PilotID = pPilotID
                                   and GalaxyID = pGalaxyID);

        set
            existingVectorID = (select VectorID
                                from tblSession
                                where PilotID = pPilotID
                                  and GalaxyID = pGalaxyID);


        update
            tblSession
        set SessionActive = true
        where SessionID = existingSessionID;

-- check last vecot
        if exists(
                select VectorID
                from tblVector
                where VectorID = existingVectorID
                  and VectorActive = true
            ) then
            update
                tblVector
            set VectorActive = false
            where VectorID = existingVectorID
              and VectorID <> homeVectorID;


            if onlineCount = 0 then
                update
                    tblGalaxy
                set ActivePilots = (select PilotNumber
                                    from tblSession
                                    where PilotID = pPilotID
                                      and GalaxyID = pGalaxyID)
                where GalaxyID = pGalaxyID;

            end if;

            select 'you live again' as message;

        else -- link to reenterShift procedure 
            select 'inaccessible - choose another vecot' as message;

        end if;

    else
        set
            currentCount = (select count(*)
                            from tblSession
                            where GalaxyID = pGalaxyID);

        set
            maxCount = (select maxPilots
                        from tblGalaxy
                        where GalaxyID = pGalaxyID);

        if currentCount < maxCount then
            set
                PilotNumber = (select count(*)
                               from tblSession
                               where GalaxyID = pGalaxyID) + 1;

-- new session
            insert into tblSession(PilotID,
                                   GalaxyID,
                                   MapID,
                                   VectorID,
                                   PilotNumber,
                                   Score,
                                   SessionActive)
            values (pPilotID,
                    pGalaxyID,
                    sessionMapID,
                    homeVectorID,
                    PilotNumber,
                    score,
                    true);

            set
                newSessionID = last_insert_id();

-- pilot inventory
            while elementType <= 4
                do
                    insert into tblInventory(ElementID, PilotID, SessionID, Quantity)
                    values (elementType, pPilotID, newSessionID, 0);

                    set
                        elementType = elementType + 1;

                end while;


            if onlineCount = 0 then
                update
                    tblGalaxy
                set ActivePilots = PilotNumber
                where GalaxyID = pGalaxyID;

            end if;

            select 'galaxy entered' as message;

        else
            select 'galaxy inaccesible' as message;

        end if;

    end if;

end//

delimiter ;

drop procedure if exists pilotMove;

delimiter //

create procedure pilotMove(
    pSessionID int,
    pPilotID int,
    pxPosition int,
    pyPosition int
)
begin
    declare currentMapID int default null;

    declare homeVectorID int default null;

    declare startVectorID int default null;

    declare targetVectorID int default null;

    declare currentGalaxyID int default null;

    declare currentCount int default null;

    declare nextPilot int default null;

    set
        currentGalaxyID = (select GalaxyID
                           from tblSession
                           where SessionID = pSessionID);

    set
        currentMapID = (select MapID
                        from tblSession
                        where SessionID = pSessionID
                          and PilotID = pPilotID);

    set
        homeVectorID = (select VectorID
                        from tblVector
                        where MapID = currentMapID
                          and xPosition = 1
                          and yPosition = 1);

    set
        startVectorID = (select VectorID
                         from tblSession
                         where SessionID = pSessionID
                           and PilotID = pPilotID);

-- checks if user can move                   
    if exists(
            select PilotNumber
            from tblSession
            where PilotNumber = (select ActivePilots
                                 from tblGalaxy
                                 where GalaxyID = currentGalaxyID)
              and SessionID = pSessionID
        ) then
        if exists(
                select *
                from tblVector as tv
                where (
                            tv.xPosition = pxPosition
                        and tv.yPosition = pyPosition
                    )
                  and tv.VectorID in (select tv2.VectorID
                                      from tblSession as s
                                               join tblVector as t on s.VectorID = t.VectorID
                                               join tblVector as tv2 on t.VectorID <> tv2.VectorID
                                      where t.MapID = currentMapID
                                        and (
                                              (tv2.xPosition = t.xPosition + 1)
                                              or (tv2.xPosition = t.xPosition - 1)
                                              or (tv2.xPosition = t.xPosition)
                                          )
                                        and (
                                              (tv2.yPosition = t.yPosition + 1)
                                              or (tv2.yPosition = t.yPosition - 1)
                                              or (tv2.yPosition = t.yPosition)
                                          )
                                        and s.SessionID = pSessionID
                                        and s.PilotID = pPilotID)
            ) then
            set
                targetVectorID = (select VectorID
                                  from tblVector
                                  where xPosition = pxPosition
                                    and yPosition = pyPosition
                                    and MapID = currentMapID);

-- is tile available
            if exists(
                    select VectorID
                    from tblVector
                    where VectorID = targetVectorID
                      and VectorActive = true
                ) then
                update
                    tblSession
                set VectorID = targetVectorID
                where SessionID = pSessionID;


                update
                    tblVector
                set VectorActive = false
                where VectorID = targetVectorID
                  and VectorID <> homeVectorID;


                update
                    tblVector
                set VectorActive = true
                where VectorID = startVectorID;


                if exists(
                        select VectorID
                        from tblVectorElement
                        where VectorID = targetVectorID
                    ) then
                    update
                        tblInventory
                    set Quantity = Quantity + 1
                    where ElementID = (select ElementID
                                       from tblVectorElement
                                       where VectorID = targetVectorID);


                    update
                        tblSession
                    set Score = Score + (select e.ElementValue
                                         from tblElement as e
                                                  join tblVectorElement as t on e.ElementID = t.ElementID
                                         where t.VectorID = targetVectorID)
                    where SessionID = pSessionID;

-- removes asset from map
                    delete
                    from tblVectorElement
                    where VectorID = targetVectorID;

                end if;

-- Update player turn 
                set
                    currentCount = (select count(*)
                                    from tblSession
                                    where GalaxyID = currentGalaxyID);

                set
                    nextPilot = (select PilotNumber
                                 from tblSession
                                 where SessionID = pSessionID);

-- find next pilot
                findNextPilot:
                loop
                    if nextPilot < CurrentCount then
                        set
                            nextPilot = nextPilot + 1;

                    else
                        set
                            nextPilot = 1;

                    end if;

-- check if nextPilot is online
                    if exists(
                            select PilotNumber
                            from tblSession
                            where GalaxyID = currentGalaxyID
                              and PilotNumber = nextPilot
                              and SessionActive = true
                        ) then
                        update
                            tblGalaxy
                        set ActivePilots = nextPilot
                        where GalaxyID = currentGalaxyID;

                        leave findNextPilot;

                    end if;

                end loop findNextPilot;

                select 'acceptable shift' as message;

            else
                select 'vector inaccessible' as message;

            end if;

        else
            select 'unacceptable shift' as message;

        end if;

    else
        select 'cooldown in progress, wait ...' as message;

    end if;

-- galaxy validation users, scores, and assets
    call checkGalaxy(pPilotID, currentGalaxyID, currentMapID);

end//

delimiter ;

drop procedure if exists reenterShift;

delimiter //

create procedure reenterShift(
    pSessionID int,
    pPilotID int,
    pGalaxyID int,
    pxPosition int,
    pyPosition int
)

begin

    declare currentMapID int default null;

    declare homeVectorID int default null;

    declare startVectorID int default null;

    declare targetVectorID int default null;

    declare currentCount int default null;

    declare nextPilot int default null;

    set
        currentMapID = (select MapID
                        from tblSession
                        where SessionID = pSessionID
                          and PilotID = pPilotID);

    set
        homeVectorID = (select VectorID
                        from tblVector
                        where MapID = currentMapID
                          and xPosition = 1
                          and yPosition = 1);

    set
        startVectorID = (select VectorID
                         from tblSession
                         where SessionID = pSessionID
                           and PilotID = pPilotID);

    if exists(
            select *
            from tblVector as tv
            where (
                        tv.xPosition = pxPosition
                    and tv.yPosition = pyPosition
                )
              and tv.VectorID in (select tv2.VectorID
                                  from tblSession as s
                                           join tblVector as t on s.VectorID = t.VectorID
                                           join tblVector as tv2 on t.VectorID <> tv2.VectorID
                                  where t.MapID = currentMapID
                                    and (
                                          (tv2.xPosition = t.xPosition + 1)
                                          or (tv2.xPosition = t.xPosition - 1)
                                          or (tv2.xPosition = t.xPosition)
                                      )
                                    and (
                                          (tv2.yPosition = t.yPosition + 1)
                                          or (tv2.yPosition = t.yPosition - 1)
                                          or (tv2.yPosition = t.yPosition)
                                      )
                                    and s.SessionID = pSessionID
                                    and s.PilotID = pPilotID)
        ) then
        set
            targetVectorID = (select VectorID
                              from tblVector
                              where xPosition = pxPosition
                                and yPosition = pyPosition
                                and MapID = currentMapID);

-- check to see if vector is available
        if exists(
                select VectorID
                from tblVector
                where VectorID = targetVectorID
                  and VectorActive = true
            ) then
            update
                tblSession
            set VectorID = targetVectorID
            where SessionID = pSessionID;

-- sets new vectore if <> starting vector
            update
                tblVector
            set VectorActive = false
            where VectorID = targetVectorID
              and VectorID <> homeVectorID;

-- score points
            if exists(
                    select VectorID
                    from tblVectorElement
                    where VectorID = targetVectorID
                ) then
                update
                    tblInventory
                set Quantity = Quantity + 1
                where ElementID = (select ElementID
                                   from tblVectorElement
                                   where VectorID = targetVectorID);


                update
                    tblSession
                set Score = Score + (select a.ElementValue
                                     from tblElement as a
                                              join tblVectorElement as t on a.ElementID = t.ElementID
                                     where t.VectorID = targetVectorID)
                where SessionID = pSessionID;

-- removes element
                delete
                from tblVectorElement
                where VectorID = targetVectorID;

            end if;


            set
                currentCount = (select count(*)
                                from tblSession
                                where GalaxyID = pGalaxyID);

            set
                nextPilot = (select PilotNumber
                             from tblSession
                             where SessionID = pSessionID);


            findNextPilot:
            loop
                if nextPilot < CurrentCount then
                    set
                        nextPilot = nextPilot + 1;

                else
                    set
                        nextPilot = 1;

                end if;


                if exists(
                        select PilotNumber
                        from tblSession
                        where GalaxyID = pGalaxyID
                          and PilotNumber = nextPilot
                          and SessionActive = true
                    ) then
                    update
                        tblGalaxy
                    set ActivePilots = nextPilot
                    where GalaxyID = pGalaxyID;

                    leave findNextPilot;

                end if;

            end loop findNextPilot;

            select 'acceptable shift' as message;

        else
            select 'vector inaccessible' as message;

        end if;

    else
        select 'unacceptable shift' as message;

    end if;


    call checkGalaxy(
            pPilotID,
            pGalaxyID,
            (select MapID
             from tblSession
             where PilotID = pPilotID
               and GalaxyID = pGalaxyID)
        );

end//

delimiter ;


drop procedure if exists administratorAdd;

delimiter //

create procedure administratorAdd(
    pPilotName varchar(30),
    pPilotPassword varchar(20),
    pEmail varchar(50),
    pAdministrator bool
)
begin
    if exists(
            select *
            from tblPilot
            where PilotName = pPilotName
        ) then
        begin
            select 'failed - pilot name exists' as message;

        end;

    else
        insert into tblPilot(PilotName,
                             PilotPassword,
                             Email,
                             LoginAttempts,
                             PilotLocked,
                             PilotOnline,
                             Administrator,
                             TotalScore)
        values (pPilotName,
                pPilotPassword,
                pEmail,
                0,
                false,
                false,
                pAdministrator,
                0);

        select 'success - pilot added' as message;

    end if;

end//

delimiter ;

drop procedure if exists adminModify;

delimiter //

create procedure adminModify(
    pPilotID int,
    pPilotName varchar(30),
    pPilotPassword varchar(20),
    pEmail varchar(50),
    pLoginAttempts int,
    pPilotLocked bool,
    pAdministrator bool,
    pTotalScore int
)
begin
    declare modifyPilot int default null;

    if exists(
            select *
            from tblPilot
            where PilotName = pPilotName
              and PilotID <> pPilotID
        ) then
        select 'failed - pilot name exists' as message;

    else
        set
            modifyPilot = (select PilotID
                           from tblPilot
                           where PilotID = pPilotID);
    end if;
    if modifyPilot is null then
        select 'failed - bad pilot id' as message;

    else
        update
            tblPilot
        set PilotName     = pPilotName,
            PilotPassword = pPilotPassword,
            Email         = pEmail,
            LoginAttempts = pLoginAttempts,
            PilotLocked   = pPilotLocked,
            Administrator = pAdministrator,
            TotalScore    = pTotalScore
        where PilotID = pPilotID;

        select 'success - pilot modified' as message;

    end if;

end//

delimiter ;

drop procedure if exists adminDelete;

delimiter //

create procedure adminDelete(pPilotID int)
begin
    declare deletePilot int default null;

    select PilotID
    into deletePilot
    from tblPilot
    where PilotID = pPilotID;

    if deletePilot is null then
        select 'failed - bad pilot id' as message;

    else
        delete
        from tblPilot
        where PilotID = pPilotID;

        select 'success - pilot delted' as message;

    end if;

end//

delimiter ;

drop procedure if exists adminKill;

delimiter //

create procedure adminKill(pGalaxyID int)
begin
    if exists(
            select GalaxyID
            from tblGalaxy
            where GalaxyID = pGalaxyID
        ) then
        delete
        from tblGalaxy
        where GalaxyID = pGalaxyID;

        select 'galaxy destroyed' as message;

    else
        select 'unacceptable galaxy' as message;

    end if;

end//

delimiter ;

drop procedure if exists checkGalaxy;
delimiter //
create procedure checkGalaxy(pPilotID int, pGalaxyID int, pMapID int)
begin
    declare galaxyScore int default null;

    declare elementCount int default null;

    declare galaxyEmperor int default null;

    set
        galaxyScore = (select Score
                       from tblSession
                       where PilotID = pPilotID
                         and GalaxyID = pGalaxyID);

    set
        elementCount = (select count(a.VectorID)
                        from tblVectorElement as a
                                 join tblVector as t on a.VectorID = t.VectorID
                        where MapID = pMapID
                          and a.ElementID <= 4);

    set
        galaxyEmperor = (select PilotID
                         from tblSession
                         where GalaxyID = pGalaxyID
                           and Score >= 10000);

-- checks if pilot died and leaves galaxy 
    if galaxyScore < 0 then
        update
            tblSession
        set SessionActive = false
        where PilotID = pPilotID
          and GalaxyID = pGalaxyID;

        update
            tblVector
        set VectorActive = true
        where VectorID = (select VectorID
                          from tblSession
                          where PilotID = pPilotID
                            and GalaxyID = pGalaxyID);

        select 'dead - you belong to the galaxy now' as message;

    end if;


    if galaxyEmperor is not null
        or elementCount <= 0 then
        set
            galaxyEmperor = (select PilotID
                             from tblSession
                             where GalaxyID = pGalaxyID
                               and Score = (select max(Score)
                                            from tblSession
                                            where GalaxyID = pGalaxyID));

-- update all users total score from galaxy
        update
            tblPilot as u
                join tblSession as s on u.PilotID = s.PilotID
        set u.TotalScore = u.TotalScore + s.Score
        where s.GalaxyID = pGalaxyID
          and s.Score > 0;

-- end quest
        delete
        from tblGalaxy
        where GalaxyID = pGalaxyID;

        select concat(
                       'this galaxy has been conquered, ',
                       (select PilotName
                        from tblPilot
                        where PilotID = galaxyEmperor),
                       ' owns this galaxy now!'
                   ) as message;

    end if;

end//

delimiter ;

drop procedure if exists gettAllPilots;

delimiter //

create procedure gettAllPilots()
begin
    select PilotName
    from tblPilot;

end//

delimiter ;

drop procedure if exists getHighScores;

delimiter //

create procedure getHighScores()
begin
    select PilotName,
           TotalScore
    from tblPilot
    order by TotalScore desc
    limit 10;

end//

delimiter ;

drop procedure if exists getPilotIneventory;

delimiter //

create procedure getPilotInventory(pSessionID int)
begin
    select a.ElementDescription as Item,
           i.Quantity
    from tblInventory as i
             join tblElement as a on i.ElementID = a.ElementID
    where SessionID = pSessionID;

end//



call ddlGalaxiasDB();

call dmlGalaxiasDB();



