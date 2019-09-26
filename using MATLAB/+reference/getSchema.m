function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'reference', 'group_shared_reference');
end
obj = schemaObject;
end
