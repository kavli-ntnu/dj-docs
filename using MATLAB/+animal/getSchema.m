function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'animal', 'prod_mlims_data');
end
obj = schemaObject;
end
