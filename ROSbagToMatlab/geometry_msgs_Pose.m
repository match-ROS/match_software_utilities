function data = geometry_msgs_Pose(bSel)

    msg = readMessages(bSel,'DataFormat','struct');
    
    for i = 1:length(msg)
        data.position.x(i) = msg{i,1}.Position.X;
        data.position.y(i) = msg{i,1}.Position.Y;
        data.orientation.x(i) = msg{i,1}.Orientation.X;
        data.orientation.y(i) = msg{i,1}.Orientation.Y;
        data.orientation.z(i) = msg{i,1}.Orientation.Z;
        data.orientation.w(i) = msg{i,1}.Orientation.W;
    end
    
end