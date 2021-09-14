%% load bag

filename = 'Three_Robots.bag';
bag = rosbag(filename);

%% open bag

structname = {};

for i = 1:height(bag.AvailableTopics(:,1))
    T = bag.AvailableTopics(i,1);
    chars = T.Properties.RowNames{1,1};
    name = convertCharsToStrings(chars);
    bSel = select(bag,'Topic',name);
    
    k = strfind(name,"/");
    if k(1) ~= 1
      error("wrong topic name")  
    end
    for idx = 2:length(k)
        structname{idx} = convertCharsToStrings(chars(1+k(idx-1):k(idx)-1)); 
    end
    
    if length(k) == 1
        fieldname = replace(name,"/","");
        raw.(fieldname) = readMessages(bSel,'DataFormat','struct'); 
    elseif length(k) == 2
        fieldname = structname{end};
        raw.(structname{2}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
    elseif length(k) == 3
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
    elseif length(k) == 4
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
    elseif length(k) == 5
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
    elseif length(k) > 5
        error("Topic name contains too many slashes")
    end

end

clear i idx k structname chars fieldname name T


