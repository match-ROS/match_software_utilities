function data = nav_msgs_OccupancyGrid(bSel)

msg = readMessages(bSel,'DataFormat','struct');

map_width = msg{1,1}.Info.Width;
map_height = msg{1,1}.Info.Height;
map_data = msg{1,1}.Data;

origin = msg{1,1}.Info.Origin;

data = zeros(map_width,map_height);
idx = 1;
for i = 1:map_height
    
    for j = 1:map_width
        
    data(i,j) = map_data(idx);
    idx = idx + 1;
    end
end

