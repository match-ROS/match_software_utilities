function data = getDataAtPath(s, path)
    % Split the path into individual field names
    fieldNames = strsplit(path, '.');
    
    % Initialize data as the top-level struct
    data = s;
    
    % Traverse the struct hierarchy
    for i = 1:length(fieldNames)
        fieldName = fieldNames{i};
        if isfield(data, fieldName)
            data = data.(fieldName);
        else
            % Handle the case where the field doesn't exist
            data = [];
            fprintf('Field "%s" does not exist in the path: %s\n', fieldName, path);
            break;
        end
    end
end