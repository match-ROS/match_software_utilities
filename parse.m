%% parse x and y positions from txt file

% Name of the file
filename = 'clicked_point2.txt';
A = textread(filename, '%s', 'whitespace', '');
string = A{1,1};

k = strfind(string,"x: ");
l = strfind(string,"y: ");

for idx =  1:length(k)
    for i = 1:30
        if string(k(idx)+2+i) ~= ' '
            X(idx,i) = string(k(idx)+2+i);
        else
            break
        end
    end
end

for idx =  1:length(l)
    for i = 1:30
        if string(l(idx)+2+i) ~= ' '
            Y(idx,i) = string(l(idx)+2+i);
        else
            break
        end
    end
end

for i = 1:length(X(:,1))
    x_pose(i) = str2num(X(i,:));
    y_pose(i) = str2num(Y(i,:));
end
