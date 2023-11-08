%% This scripts parses all rosbags from a given folder and stores the data as a ".mat" format.

clear all;
dir_name = 'manual_tuning';

%% load rosbag

dinfo = dir(fullfile(dir_name));
dinfo([dinfo.isdir]) = [];     %get rid of all directories including . and ..
nfiles = length(dinfo);



for i = 1:nfiles
    filename = fullfile(dir_name, dinfo(i).name);
    bag = rosbag(filename);
    
    data_unformatted = load_rosbag(bag);
    data_structured = format_rosbag(data_unformatted);
    
    save_name = filename(1:end-3); %remove the "bag" ending
    foldername = split(save_name,'\');
    mkdir(foldername{1},'\parsed')
    parsed_file_name = append(foldername{1},'\parsed\', foldername(2),'mat');
    save(parsed_file_name{1},'data_structured');
end
