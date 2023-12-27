function structured_data = tf2_msgs_TFMessage(data_struct)

structured_data = [];

for i = 1:length(data_struct)
                
        for j = 1:length(length(data_struct(i).Transforms))
            raw_frame_id =  data_struct(i).Transforms(j).ChildFrameId;
            
            % remove leading slashes
            raw_frame_id(raw_frame_id == '/') = [];

            frame_id = strrep(raw_frame_id, '/', '_');
            
            if isfield(structured_data,frame_id)
                structured_data.(frame_id).transform.translation.x(end +1) = data_struct(i).Transforms(j).Transform.Translation.X;
                structured_data.(frame_id).transform.translation.y(end +1) = data_struct(i).Transforms(j).Transform.Translation.Y;
                structured_data.(frame_id).transform.translation.z(end +1) = data_struct(i).Transforms(j).Transform.Translation.Z;
                
                structured_data.(frame_id).transform.rotation.x(end +1) = data_struct(i).Transforms(j).Transform.Rotation.X;
                structured_data.(frame_id).transform.rotation.y(end +1) = data_struct(i).Transforms(j).Transform.Rotation.Y;
                structured_data.(frame_id).transform.rotation.z(end +1) = data_struct(i).Transforms(j).Transform.Rotation.Z;
                structured_data.(frame_id).transform.rotation.w(end +1) = data_struct(i).Transforms(j).Transform.Rotation.W;
                eulZYX = quat2eul([data_struct(i).Transforms(j).Transform.Rotation.X,data_struct(i).Transforms(j).Transform.Rotation.Y, ...
                    data_struct(i).Transforms(j).Transform.Rotation.Z,data_struct(i).Transforms(j).Transform.Rotation.W]);
                structured_data.(frame_id).transform.rotation.eulX(end +1) = eulZYX(1);
                structured_data.(frame_id).transform.rotation.eulY(end +1) = eulZYX(2);
                structured_data.(frame_id).transform.rotation.eulZ(end +1) = eulZYX(3);
                
                structured_data.(frame_id).transform.timestamp(end +1) = data_struct(i).Transforms(j).Header.Stamp.Sec + data_struct(i).Transforms(j).Header.Stamp.Nsec * 10^-9;
                
            else
                structured_data.(frame_id).transform.translation.x(1) = data_struct(i).Transforms(j).Transform.Translation.X;
                structured_data.(frame_id).transform.translation.y(1) = data_struct(i).Transforms(j).Transform.Translation.Y;
                structured_data.(frame_id).transform.translation.z(1) = data_struct(i).Transforms(j).Transform.Translation.Z;

                structured_data.(frame_id).transform.rotation.x(1) = data_struct(i).Transforms(j).Transform.Rotation.X;
                structured_data.(frame_id).transform.rotation.y(1) = data_struct(i).Transforms(j).Transform.Rotation.Y;
                structured_data.(frame_id).transform.rotation.z(1) = data_struct(i).Transforms(j).Transform.Rotation.Z;
                structured_data.(frame_id).transform.rotation.w(1) = data_struct(i).Transforms(j).Transform.Rotation.W;
                eulZYX = quat2eul([data_struct(i).Transforms(j).Transform.Rotation.X,data_struct(i).Transforms(j).Transform.Rotation.Y, ...
                    data_struct(i).Transforms(j).Transform.Rotation.Z,data_struct(i).Transforms(j).Transform.Rotation.W]);
                structured_data.(frame_id).transform.rotation.eulX(1) = eulZYX(1);
                structured_data.(frame_id).transform.rotation.eulY(1) = eulZYX(2);
                structured_data.(frame_id).transform.rotation.eulZ(1) = eulZYX(3);
                
                structured_data.(frame_id).transform.timestamp(1) = data_struct(i).Transforms(j).Header.Stamp.Sec + data_struct(i).Transforms(j).Header.Stamp.Nsec * 10^-9;
                
            end
            

        end
        
       
       
end

frame_names = fieldnames(structured_data);
for i = 1:length(frame_names)
    frame_id = frame_names{i};
    structured_data.(frame_id).transform.rotation.eulXYZ = [unwrap(structured_data.(frame_id).transform.rotation.eulX); ...
        unwrap(structured_data.(frame_id).transform.rotation.eulY); unwrap(structured_data.(frame_id).transform.rotation.eulZ)];


end