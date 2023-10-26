function structured_data = geometry_msgs_PoseWithCovarianceStamped(data_struct)

structured_data = []

for i = length(data_struct)
   structured_data.pose.pose.position.x = data_struct(i).Pose.Pose.Position.X;
   structured_data.pose.pose.position.y = data_struct(i).Pose.Pose.Position.Y;
   structured_data.pose.pose.position.z = data_struct(i).Pose.Pose.Position.Z;
   
   structured_data.pose.pose.orientation.x = data_struct(i).Pose.Pose.Orientation.X;
   structured_data.pose.pose.orientation.y = data_struct(i).Pose.Pose.Orientation.Y;
   structured_data.pose.pose.orientation.z = data_struct(i).Pose.Pose.Orientation.Z;
   structured_data.pose.pose.orientation.w = data_struct(i).Pose.Pose.Orientation.W;
   
end

end