import datajoint as dj

imaging = dj.schema(dj.config["custom"]["dj_imaging.database"])
imaging.spawn_missing_classes()

fig = (
    dj.ERD(ExperimentType) + dj.ERD(Session) + dj.ERD(Session.Data)
    + dj.ERD(Setup) + dj.ERD(Setup.Sync)
    + dj.ERD(Tracking) + dj.ERD(Tracking.OpenField) 
    + dj.ERD(Sync) + dj.ERD(Sync.Ws) + dj.ERD(Sync.Mesc) + dj.ERD(Sync.SI)
    + dj.ERD(SignalTracking)
)

fig.save(r"../../../docs/_static/imaging/schemas/erd_sync.png")