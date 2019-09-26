function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'tracking', 'group_shared_tracking');
end
obj = schemaObject;
end
