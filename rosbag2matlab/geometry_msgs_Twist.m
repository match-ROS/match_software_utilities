function structured_data = geometry_msgs_Twist(data_struct)

structured_data = [];

for i = 1:length(data_struct)
   structured_data.linear.x(i) = data_struct(i).Linear.X;
   structured_data.linear.y(i) = data_struct(i).Linear.Y;
   structured_data.linear.z(i) = data_struct(i).Linear.Z;
   
   structured_data.angular.x(i) = data_struct(i).Angular.X;
   structured_data.angular.y(i) = data_struct(i).Angular.Y;
   structured_data.angular.z(i) = data_struct(i).Angular.Z;   
end

end