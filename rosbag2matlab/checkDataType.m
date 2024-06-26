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
        
        if data_type == "nav_msgs/Odometry"
            data_cell_structured = nav_msgs_Odometry(data);
        end
        
        if data_type == "tf2_msgs/TFMessage" || data_type == "tf/tfMessage"
            data_cell_structured = tf2_msgs_TFMessage(data);
        end 
        
        if data_type == "geometry_msgs/WrenchStamped" 
            data_cell_structured = wrench_stamped(data);
        end
        
    end
end

