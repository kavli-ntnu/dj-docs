function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'behavior', 'group_shared_behavior');
end
obj = schemaObject;
end
