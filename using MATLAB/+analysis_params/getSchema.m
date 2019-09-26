function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'analysis_params', 'group_shared_analysis_params');
end
obj = schemaObject;
end
