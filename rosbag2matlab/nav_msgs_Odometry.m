function data = nav_msgs_Path(bSel)

    msg = readMessages(bSel,'DataFormat','struct');
    
    if isempty(msg{1,1})
        data = 0;
        return
    end
 
    for i = 1:length(msg)
        data.pose.position.x(i) = msg{i,1}.Pose.Pose.Position.X;
        data.pose.position.y(i) = msg{i,1}.Pose.Pose.Position.Y;
        data.pose.orientation.x(i) = msg{i,1}.Pose.Pose.Orientation.X;
        data.pose.orientation.y(i) = msg{i,1}.Pose.Pose.Orientation.Y;
        data.pose.orientation.z(i) = msg{i,1}.Pose.Pose.Orientation.Z;
        data.pose.orientation.w(i) = msg{i,1}.Pose.Pose.Orientation.W;

        Nsec = double(msg{i,1}.Header.Stamp.Nsec);
        sec = double(msg{i,1}.Header.Stamp.Sec);
        data.header.timestamp(i) = sec + Nsec / 10^9 ;
    end

end