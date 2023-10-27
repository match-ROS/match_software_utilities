function data_structured = format_rosbag(data_unformatted)

data_structured = [];

rosbag_fieldnames = fieldnames(data_unformatted);
for idx = 1:length(rosbag_fieldnames)
    name = rosbag_fieldnames{idx};
    data_entry = data_unformatted.(name);
    data_type = "none"; % intialize as none - change is type is found
    
         
    topic_names = fieldnames(data_entry);

    % if the structure has more then two fields, check if one of
    % them is MessageType
        structPaths = recursive_search(data_entry,'');

    for i = 1:length(structPaths)
        path = structPaths{i};
        data = getDataAtPath(data_entry, path);

        if ~isempty(data)
            data_cell_structured = checkDataType(data);

            if isstruct(data_cell_structured) 
                eval(append('data_structured.',name, '.', path,'=data_cell_structured'))
            end
        end

        
    end
    

    
end

end


