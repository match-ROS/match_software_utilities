function structured_data = geometry_msgs_PoseStamped(data_struct)

structured_data = [];

for i = 1:length(data_struct)
   structured_data.pose.position.x(i) = data_struct(i).Pose.Position.X;
   structured_data.pose.position.y(i) = data_struct(i).Pose.Position.Y;
   structured_data.pose.position.z(i) = data_struct(i).Pose.Position.Z;
   
   structured_data.pose.orientation.x(i) = data_struct(i).Pose.Orientation.X;
   structured_data.pose.orientation.y(i) = data_struct(i).Pose.Orientation.Y;
   structured_data.pose.orientation.z(i) = data_struct(i).Pose.Orientation.Z;
   structured_data.pose.orientation.w(i) = data_struct(i).Pose.Orientation.W;
   
end

end