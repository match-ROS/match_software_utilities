function data = nav_msgs_Path(bSel)

    msg = readMessages(bSel,'DataFormat','struct');
    
    for i = 1:length(msg)
        data.linear.x(i) = msg{i,1}.Linear.X;
        data.linear.y(i) = msg{i,1}.Linear.Y;
        data.angular.z(i) = msg{8,1}.Angular.Z;
    end
end