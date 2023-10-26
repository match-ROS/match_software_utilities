function newStruct = storeDataAtPath(s, path, data)
    % Create a copy of the original struct
    newStruct = s;
    
    % Split the path into individual field names
    fieldNames = strsplit(path, '.');
    eval(append(path,'=data'))
    
    dataCombined.(fieldNames(1)).((fieldNames(2)).(fieldNames(3)) = data
    
    
    % Traverse the struct hierarchy to set the data at the specified path
    currentStruct = newStruct;
    for i = 1:length(fieldNames)
        fieldName = fieldNames{i};
        if ~isfield(currentStruct, fieldName) && i == 1
%            % Create a new struct if it doesn't exist
             currentStruct.(fieldName) = struct();
        else
            currentStruct.(fieldName) = currentStruct;
        end
%         if i < length(fieldNames)
%             if ~isfield(currentStruct, fieldName) || ~isstruct(currentStruct.(fieldName))
%                 % Create a new struct if it doesn't exist
%                 currentStruct.(fieldName) = struct();
%             end
%             currentStruct = currentStruct.(fieldName);
%         else
%             % Set the data in the final field
%             currentStruct.(fieldName) = data;
%         end
    end
end