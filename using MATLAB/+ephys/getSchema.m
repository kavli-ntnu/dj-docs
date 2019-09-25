function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'ephys', 'group_shared_ephys');
end
obj = schemaObject;
end
