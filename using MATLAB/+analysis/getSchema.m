function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'analysis', 'group_shared_analysis');
end
obj = schemaObject;
end
