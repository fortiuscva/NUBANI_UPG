tableextension 50016 ReservationEntryExt extends "Reservation Entry"
{
    fields
    {
        field(50000; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(50001; "New Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
    }
}

