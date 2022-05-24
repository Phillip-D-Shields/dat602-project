create
    definer = root@localhost procedure pilotRegistration(IN pPilotName varchar(30), IN pPilotPassword varchar(20),
                                                        IN pEmail varchar(50))
begin if exists (
        select
            *
        from
            tblPilot
        where
                PilotName = pPilotName
    ) then begin
    select
        'failed - pilot name exists' as message;

end;

else
    insert into
        tblPilot(
        PilotName,
        PilotPassword,
        Email,
        LoginAttempts,
        PilotLocked,
        PilotOnline,
        Administrator,
        TotalScore
    )
    values
        (pPilotName, pPilotPassword, pEmail, 0, 0, 0, 0, 0);

    select
        'success - pilot added' as message;

end if;

end;

