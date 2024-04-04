function structured_data = wrench_stamped(data_struct)

structured_data = [];

for i = 1:length(data_struct)
   structured_data.wrench.force.x(i) = data_struct(i).Wrench.Force.X;
   structured_data.wrench.force.y(i) = data_struct(i).Wrench.Force.Y;
   structured_data.wrench.force.z(i) = data_struct(i).Wrench.Force.Z;
   
   structured_data.wrench.torque.x(i) = data_struct(i).Wrench.Torque.X;
   structured_data.wrench.torque.y(i) = data_struct(i).Wrench.Torque.Y;
   structured_data.wrench.torque.z(i) = data_struct(i).Wrench.Torque.Z;

   structured_data.pose.timestamp(i) = data_struct(i).Header.Stamp.Sec + data_struct(i).Header.Stamp.Nsec * 10^-9;
end

end