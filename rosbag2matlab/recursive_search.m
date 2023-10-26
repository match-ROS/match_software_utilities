function structPaths = recursive_search(s, parentName)
    % Initialize the cell array to store struct paths
    structPaths = {};
    
    % Check if the input is a struct
    if isstruct(s) && isempty(s) ~= 1
        % Get the field names of the struct
        fieldNames = fieldnames(s);
        
        % Check if the struct contains a field called 'MessageType'
        if isfield(s, 'MessageType')
            % If it does, store the name of the struct
            structPaths{end+1} = parentName;
        end

        % Recursively search the sub-structs
        for i = 1:length(fieldNames)
            fieldName = fieldNames{i};
            fieldValue = s.(fieldName);
            % Generate the parentName for the next level of recursion
            if isempty(parentName)
                nextParentName = fieldName;
            else
                nextParentName = [parentName '.' fieldName];
            end
            % Recursively search the sub-struct and append the paths
            subPaths = recursive_search(fieldValue, nextParentName);
            structPaths = [structPaths, subPaths];
        end
    elseif isempty(s)
        % Handle the case where the field is empty
        fprintf('Empty field at: %s\n', parentName);
    end
end




%         % Check if the input is a struct
%     if isstruct(s) && isempty(s) ~= 1
%         % Get the field names of the struct
%         fieldNames = fieldnames(s);
%         
%         % Check if the struct contains a field called 'MessageType'
%         if isfield(s, 'MessageType')
%             % If it does, print the name of the struct
%             fprintf('Found MessageType in struct: %s\n', parentName);
%         end
% 
%         % Recursively search the sub-structs
%         for i = 1:length(fieldNames)
%             fieldName = fieldNames{i};
%             fieldValue = s.(fieldName);
%             % Generate the parentName for the next level of recursion
%             if isempty(parentName)
%                 nextParentName = fieldName;
%             else
%                 nextParentName = [parentName '.' fieldName];
%             end
%             % Recursively search the sub-struct
%             recursive_search(fieldValue, nextParentName);
%         end
%     elseif isempty(s)
%         % Handle the case where the field is empty
%         fprintf('Empty field at: %s\n', parentName);
%     end
% end


% function [data_type,path] = recursive_search(data)
% 
%     if isstruct(data)
%         topic_names = fieldnames(data);
% 
%         for i = 1:length(topic_names)
%             recursive_search(data.(topic_names{i}))
%         end
%         
%     else
%     
%         data_type = 0 ;
%         path = 0;
%         
%     end
%     
% 
% end