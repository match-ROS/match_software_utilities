function data_unformatted = load_rosbag(bag)


%% open bag

structname = {};
data_unformatted = [];

for i = 1:height(bag.AvailableTopics(:,1))
    T = bag.AvailableTopics(i,1);
    chars = T.Properties.RowNames{1,1};
    name = convertCharsToStrings(chars);
    bSel = select(bag,'Topic',name);
    structname = {};
    
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
        raw.(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data_unformatted.(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
    elseif length(k) == 2
        fieldname = structname{end};
        raw.(structname{2}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data_unformatted.(structname{2}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
        %proccess_data(readMessages(bSel,'DataFormat','struct'),structname);
    elseif length(k) == 3
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data_unformatted.(structname{2}).(structname{3}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
        %proccess_data(readMessages(bSel,'DataFormat','struct'),structname,bSel);
    elseif length(k) == 4
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data_unformatted.(structname{2}).(structname{3}).(structname{4}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
    elseif length(k) == 5
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data_unformatted.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct'));
    elseif length(k) > 5
        error("Topic name contains too many slashes")
    end

end
end

