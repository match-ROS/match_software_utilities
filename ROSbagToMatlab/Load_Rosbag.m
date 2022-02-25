%% load bag

filename = '2022-02-22-17-08-44.bag';
%filename = '2022-02-22-16-38-55.bag';

bag = rosbag(filename);

%% open bag

structname = {};
data = [];

for i = 1:height(bag.AvailableTopics(:,1))
    T = bag.AvailableTopics(i,1);
    tmp = bag.AvailableTopics(i,3);
    C = table2cell(bag.AvailableTopics);
    topic_type = C{i,2};
    chars = T.Properties.RowNames{1,1};
    name = convertCharsToStrings(chars);
    bSel = select(bag,'Topic',name);
    structname = {};
    
    
    if topic_type == 'geometry_msgs/Pose'
       msg = geometry_msgs_Pose(bSel); 
    elseif topic_type == 'nav_msgs/Path'
       msg = nav_msgs_Path(bSel); 
    elseif topic_type == 'geometry_msgs/Twist'
       msg = geometry_msgs_Twist(bSel); 
    elseif topic_type == 'nav_msgs/OccupancyGrid'
        msg = nav_msgs_OccupancyGrid(bSel);
    else
        msg = readMessages(bSel,'DataFormat','struct');
    end
    
    
    
    k = strfind(name,"/");
    if k(1) ~= 1
      error("wrong topic name")  
    end

    k(end+1) = length(chars);
    for idx = 2:length(k)
        if idx == length(k)
            structname{idx} = convertCharsToStrings(chars(1+k(idx-1):k(idx)));
        else
            structname{idx} = convertCharsToStrings(chars(1+k(idx-1):k(idx)-1));
        end
    end
    
    if length(k) == 1
        fieldname = replace(name,"/","");
        raw.(fieldname) = msg; 
    elseif length(k) == 2
        fieldname = structname{end};
        raw.(structname{2}).(fieldname) = msg; 
    elseif length(k) == 3
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(fieldname) = msg; 
    elseif length(k) == 4
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(fieldname) = msg;  
    elseif length(k) == 5
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(fieldname) = msg; 
     elseif length(k) == 6
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(structname{6}).(fieldname) = msg; 
     elseif length(k) == 7
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(structname{6}).(structname{7}).(fieldname) = msg; 
     elseif length(k) == 8
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(structname{6}).(structname{7}).(structname{8}).(fieldname) = msg; 
    elseif length(k) > 8
        error("Topic name contains too many slashes")
    end

end

%% TF

Transformations = [];

for i = 1:length(raw.tf.tf)
   
    tf = raw.tf.tf{i,1};
    if length(tf.Transforms) > 1
        continue
    end
    child_frame = tf.Transforms.ChildFrameId;
    Nsec = double(tf.Transforms.Header.Stamp.Nsec);
    sec = double(tf.Transforms.Header.Stamp.Sec);
    timestamp = sec + Nsec / 10^9 ;
    translation = tf.Transforms.Transform.Translation;
    rotation = tf.Transforms.Transform.Rotation;
    
    fieldname = replace(child_frame,"/","_");
    if isfield(Transformations,fieldname)
        Transformations.(fieldname).translation.X(end+1) = translation.X;
        Transformations.(fieldname).translation.Y(end+1) = translation.Y;
        eulZYX = quat2eul([rotation.X rotation.Y rotation.Z rotation.W]);
        Transformations.(fieldname).rotation.Z(end+1) = eulZYX(3);
    else
        Transformations.(fieldname).translation.X = translation.X;
        Transformations.(fieldname).translation.Y = translation.Y;
        eulZYX = quat2eul([rotation.X rotation.Y rotation.Z rotation.W]);
        Transformations.(fieldname).rotation.Z = eulZYX(3);
    end
    
end
