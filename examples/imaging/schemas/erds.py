import datajoint as dj

imaging = dj.schema(dj.config["custom"]["dj_imaging.database"])
imaging.spawn_missing_classes()

tables_overview = (
    imaging.Session,
    imaging.Recording,
    imaging.Recording.Data,
    imaging.Dataset,
    imaging.PhysicalFile,
    imaging.Tif,
    imaging.Sync,
    imaging.Mesc,
    imaging.TrackingRaw,
    imaging.ImagingAnalysis,
    imaging.Projection,
    imaging.ProjectionCorr,
    imaging.Cell,
    imaging.Cell.Rois,
    imaging.RoisCorr,
    imaging.Cell.Traces,
    imaging.Cell.Events,
    imaging.FilteredEvents,
    imaging.SNR,
    imaging.Tracking,
    imaging.SignalTracking,
    imaging.Occupancy,
    imaging.AngularOccupancy,
    imaging.Ratemap,
    imaging.GridScore,
    imaging.BorderScore,
    imaging.AngularRate,
    imaging.AngularRate.Stats,
)

tables_dlc = (
    imaging.Recording,
    imaging.Recording.Data,
    imaging.DLCPrediction,
    imaging.DLCTrackingType,
    imaging.DLCTrackingProcessingMethod,
    imaging.TrackingRaw,
    imaging.TrackingRaw.DLCPart,
    imaging.Tracking,
    imaging.Tracking.DLCPart,
    imaging.TrackedBodyPart,
    imaging.DLCModel,
    imaging.DLCProcessingMethod,
    imaging.RecordingDLC,
)

tables_sync = (
    imaging.EquipmentType,
    imaging.Recording,
    imaging.Recording.Data,
    imaging.Tracking,
    imaging.Tracking.Linear,
    imaging.Tracking.OpenField,
    imaging.SignalTracking,
    imaging.Sync,
    imaging.Sync.Unprocessed,
    imaging.Sync.Ws,
    imaging.Sync.Mesc,
    imaging.SystemConfig,
    imaging.SystemConfig.Tracking2D,
    imaging.SystemConfig.Tracking1D,
    imaging.SystemConfig.Sync,
)

tables_fov = (
    imaging.Scope,
    imaging.SystemConfig,
    imaging.Session,
    imaging.Session.SystemConfig,
    imaging.ImagingFOVRaw,
    imaging.ImagingFOVRaw.Beads,
    imaging.ImagingFOV,
    imaging.ImagingAnalysis,
    imaging.Cell,
    imaging.Cell.Rois,
    imaging.RoisCorr,
    imaging.Projection,
    imaging.ProjectionCorr,
)


group = tables_fov
d = dj.ERD(group[0])
for i in range(len(group[1:])):
    d += dj.ERD(group[i])
d
# For some reason, this approach sometimes seems to skip the final table in the list. No idea why. 

fig.save(r"../../../docs/_static/imaging/schemas/erd_sync.png")