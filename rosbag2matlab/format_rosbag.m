data_structured = [];

rosbag_fieldnames = fieldnames(data_unformatted);
for idx = 1:length(rosbag_fieldnames)
    name = rosbag_fieldnames{idx};
    data = data_unformatted.(name);
    
    % get data type
    if isfield(data, name)
        data_type = data.(name).MessageType;
        data_cell_structured = [];
        
        if data_type == "geometry_msgs/PoseWithCovarianceStamped"
            data_cell_structured = geometry_msgs_PoseWithCovarianceStamped(data.(name));
        end
        
        if data_type == "geometry_msgs/PoseStamped"
            data_cell_structured = geometry_msgs_PoseStamped(data.(name));
        end
        
        if isstruct(data_cell_structured) 
            data_structured.(name) = data_cell_structured;
        end

    
        
        
    end
    
end