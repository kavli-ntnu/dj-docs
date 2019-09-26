function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'acquisition', 'group_shared_acquisition');
end
obj = schemaObject;
end
