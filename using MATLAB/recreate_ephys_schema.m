clc, close all, clear all

ephys_schemas = {'animal', 'reference', 'acquisition',...
                 'tracking', 'behavior',...
                 'ephys', 'analysis', 'analysis_params'};
             
database_prefi = 'group_shared_';


for schema_i = 1:numel(ephys_schemas)
    schema_name = ephys_schemas(schema_i);
    
    schema_name = schema_name{1};
    
    if strcmp(schema_name, 'animal')
        schema_db_name = 'prod_mlims_data';
    else
        schema_db_name = [database_prefi, schema_name];
    end
    
    dj.createSchema(schema_name, '.', schema_db_name)
 
    schema =  dj.Schema(dj.conn, schema_name, schema_db_name);
    
    for tbl_i = 1: numel(schema.classNames)
        tbl_name = schema.classNames(tbl_i);
        tbl_name = tbl_name{1}
        
        if contains(tbl_name, 'Log')...
                || contains(tbl_name, 'Jobs')...
                || contains(tbl_name, 'External')
            continue
        end
        
        dj.new(tbl_name)
        pause(0.1)
    end
end
             
             
             
             