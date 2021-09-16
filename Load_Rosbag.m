%% load bag

filename = 'Three_Robots.bag';
bag = rosbag(filename);

%% open bag

structname = {};
data = [];

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
        data.(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
    elseif length(k) == 2
        fieldname = structname{end};
        raw.(structname{2}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data.(structname{2}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
        proccess_data(readMessages(bSel,'DataFormat','struct'),structname);
    elseif length(k) == 3
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data.(structname{2}).(structname{3}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
        proccess_data(readMessages(bSel,'DataFormat','struct'),structname,bSel);
    elseif length(k) == 4
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data.(structname{2}).(structname{3}).(structname{4}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct')); 
    elseif length(k) == 5
        fieldname = structname{end};
        raw.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(fieldname) = readMessages(bSel,'DataFormat','struct'); 
        data.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(fieldname) = cell2mat(readMessages(bSel,'DataFormat','struct'));
    elseif length(k) > 5
        error("Topic name contains too many slashes")
    end

end


%%

clear i idx k structname chars fieldname name T

%%

function proccess_data(input,structnames,bSel)
    msg = cell2mat(input);
    names = fieldnames(msg);
    
    for i = 1:length(names)
        name_array = {};
        name = names{i};
        if isstruct(msg(1).(name)) == 1
            name_array{end+1} = convertCharsToStrings(name);
            data = [];
            [~,output] = process_struct(msg(1).(name),name_array,structnames,bSel,data);
        end
    end
end


function [name_array,data,loopcounter] = process_struct(struct,name_array,structnames,bSel,data,loopcounter)
    loopcounter = 1;
    if isstruct(struct)
        names = fieldnames(struct);
        for i = 1:length(names)
            name = names{i};
            name_array{end+1} = convertCharsToStrings(name);
            [name_array,data,loopcounter] = process_struct(struct.(name),name_array,structnames,bSel,data,loopcounter);
        end
        loopcounter = loopcounter + 1;
    else
        name = 1;
%         structname = structnames;
%         for j = 1:length(name_array)
%             structname{end+1} = name_array{j};
%         end
        %msg = cell2mat(readMessages(bSel,'DataFormat','struct'));
        data = createDataStruct(structnames,name_array,bSel,data);
        name_array_temp = {};
        for i = 1:length(name_array)-loopcounter
            name_array_temp{i} = name_array{i};
        end
        name_array = name_array_temp;
    end

end

function data = createDataStruct(structnames,name_array,bSel,data)
    msg = cell2mat(readMessages(bSel,'DataFormat','struct'));
    for i = 2:length(msg)
        if length(name_array) == 1
             message = msg(i,1).(name_array{1});   
            if isa(message,'char') == 1
                message = convertCharsToStrings(message);
            end
            messages(i) = message;
        elseif length(name_array) == 2
            message = msg(i,1).(name_array{1}).(name_array{2});
            if isa(message,'char') == 1
                message = convertCharsToStrings(message);
            end
            messages(i) = message;
        elseif length(name_array) == 3
            message = msg(i,1).(name_array{1}).(name_array{2}).(name_array{3});
            if isa(message,'char') == 1
                message = convertCharsToStrings(message);
            end
            messages(i) = message;
        elseif length(name_array) == 4
            message = msg(i,1).(name_array{1}).(name_array{2}).(name_array{3}).(name_array{4});
            if isa(message,'char') == 1
                message = convertCharsToStrings(message);
            end
            messages(i) = message;
        end
    end
    structname = structnames;
    for j = 1:length(name_array)
        structname{end+1} = name_array{j};
    end
    
    if length(structname) == 2
        data.(structname{2}) = messages;
    elseif length(structname) == 3
        data.(structname{2}).(structname{3}) = messages;
    elseif length(structname) == 4
        data.(structname{2}).(structname{3}).(structname{4}) = messages;
    elseif length(structname) == 5
        data.(structname{2}).(structname{3}).(structname{4}).(structname{5}) = messages;
    elseif length(structname) == 6
        data.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(structname{6}) = messages;
    elseif length(structname) == 7
        data.(structname{2}).(structname{3}).(structname{4}).(structname{5}).(structname{6}).(structname{7}) = messages;
    end
end
