function data_cell_structured = checkDataType(data)
    %% if type was found check if type is known
    data_type = data.MessageType;
    data_cell_structured = [];
    
    if data_type ~= "none"
    
        if data_type == "geometry_msgs/PoseWithCovarianceStamped"
            data_cell_structured = geometry_msgs_PoseWithCovarianceStamped(data);
        end

        if data_type == "geometry_msgs/PoseStamped"
            data_cell_structured = geometry_msgs_PoseStamped(data);
        end
        
        if data_type == "geometry_msgs/Pose"
            data_cell_structured = geometry_msgs_Pose(data);
        end
        
        if data_type == "geometry_msgs/Twist"
            data_cell_structured = geometry_msgs_Twist(data);
        end
        
    end
end

