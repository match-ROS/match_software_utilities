function structured_data = geometry_msgs_PoseWithCovarianceStamped(data_struct)

structured_data = [];

for i = 1:length(data_struct)
   structured_data.pose.pose.position.x(i) = data_struct(i).Pose.Pose.Position.X;
   structured_data.pose.pose.position.y(i) = data_struct(i).Pose.Pose.Position.Y;
   structured_data.pose.pose.position.z(i) = data_struct(i).Pose.Pose.Position.Z;
   
   structured_data.pose.pose.orientation.x(i) = data_struct(i).Pose.Pose.Orientation.X;
   structured_data.pose.pose.orientation.y(i) = data_struct(i).Pose.Pose.Orientation.Y;
   structured_data.pose.pose.orientation.z(i) = data_struct(i).Pose.Pose.Orientation.Z;
   structured_data.pose.pose.orientation.w(i) = data_struct(i).Pose.Pose.Orientation.W;
   
end

end