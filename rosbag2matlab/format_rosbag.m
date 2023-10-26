data_structured = [];

rosbag_fieldnames = fieldnames(data_unformatted);
for idx = 1:length(rosbag_fieldnames)
    name = rosbag_fieldnames{idx};
    data_entry = data_unformatted.(name);
    data_type = "none" % intialize as none - change is type is found
    
    % get data type
    if isfield(data_entry, name)
        data_type = data_entry.(name).MessageType;
        data_cell_structured = [];
                
    else 
        
        topic_names = fieldnames(data_entry);
        if length(topic_names) == 1
            sub_topic_names = fieldnames(data_entry.(topic_names{1}));
            if length(sub_topic_names) == 1
                sub_topic_names = fieldnames(data_entry.(topic_names{1}));
            else
                continue
            end
        else    
            % if the structure has more then two fields, check if one of
            % them is MessageType
            if isfield(data_entry,'MessageType')
                data_type = data_entry.(topic_names).MessageType;
            else % if not, check one level deeper
                structPaths = recursive_search(data_entry,'');
                
                for i = 1:length(structPaths)
                    path = structPaths{i};
                    data = getDataAtPath(data_entry, path);

                    if ~isempty(data)
                        data_cell_structured = checkDataType(data);
                    
                        if isstruct(data_cell_structured) 
                            %data_structured.(path) = data_cell_structured;
                            %data_structured  = storeDataAtPath(data_structured, path, data_cell_structured);
                            eval(append('data_structured.',name, '.', path,'=data_cell_structured'))
                        end
                    end
                end
                
            end
        end
        
    end
    

    
end



