function structured_data = geometry_msgs_PoseStamped(data_struct)

structured_data = []

for i = length(data_struct)
   structured_data.pose.position.x = data_struct(i).Pose.Position.X;
   structured_data.pose.position.y = data_struct(i).Pose.Position.Y;
   structured_data.pose.position.z = data_struct(i).Pose.Position.Z;
   
   structured_data.pose.orientation.x = data_struct(i).Pose.Orientation.X;
   structured_data.pose.orientation.y = data_struct(i).Pose.Orientation.Y;
   structured_data.pose.orientation.z = data_struct(i).Pose.Orientation.Z;
   structured_data.pose.orientation.w = data_struct(i).Pose.Orientation.W;
   
end

end