function data = nav_msgs_Path(bSel)

    msg = readMessages(bSel,'DataFormat','struct');
    
    for i = 1:length(msg{1,1}.Poses)
        data.pose.position.x(i) = msg{1,1}.Poses(i).Pose.Position.X;
        data.pose.position.y(i) = msg{1,1}.Poses(i).Pose.Position.Y;
        data.pose.orientation.x(i) = msg{1,1}.Poses(i).Pose.Orientation.X;
        data.pose.orientation.y(i) = msg{1,1}.Poses(i).Pose.Orientation.Y;
        data.pose.orientation.z(i) = msg{1,1}.Poses(i).Pose.Orientation.Z;
        data.pose.orientation.w(i) = msg{1,1}.Poses(i).Pose.Orientation.W;
        
        Nsec = double(msg{1,1}.Poses(i).Header.Stamp.Nsec);
        sec = double(msg{1,1}.Poses(i).Header.Stamp.Sec);
        data.header.timestamp(i) = sec + Nsec / 10^9 ;
    end
end