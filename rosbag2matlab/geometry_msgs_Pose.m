function structured_data = geometry_msgs_Pose(data_struct)

structured_data = [];

for i = 1:length(data_struct)
   structured_data.position.x(i) = data_struct(i).Position.X;
   structured_data.position.y(i) = data_struct(i).Position.Y;
   structured_data.position.z(i) = data_struct(i).Position.Z;
   
   structured_data.orientation.x(i) = data_struct(i).Orientation.X;
   structured_data.orientation.y(i) = data_struct(i).Orientation.Y;
   structured_data.orientation.z(i) = data_struct(i).Orientation.Z;
   structured_data.orientation.w(i) = data_struct(i).Orientation.W;
   
end

end