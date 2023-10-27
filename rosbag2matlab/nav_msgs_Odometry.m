function structured_data = nav_msgs_Odometry(data_struct)

    
structured_data = [];

for i = 1:length(data_struct)
   structured_data.twist.linear.x(i) = data_struct(i).Twist.Twist.Linear.X;
   structured_data.twist.linear.y(i) = data_struct(i).Twist.Twist.Linear.Y;
   structured_data.twist.linear.z(i) = data_struct(i).Twist.Twist.Linear.Z;

   
   structured_data.twist.angular.x(i) = data_struct(i).Twist.Twist.Angular.X;
   structured_data.twist.angular.y(i) = data_struct(i).Twist.Twist.Angular.Y;
   structured_data.twist.angular.z(i) = data_struct(i).Twist.Twist.Angular.Z;

end

end