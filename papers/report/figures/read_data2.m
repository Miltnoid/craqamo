clear 
close all
mix_read =  [];
mix_write = [];


fid = fopen('data.ecsc.txt');

tline = fgetl(fid);
while ischar(tline)
    if length(tline) > 8 && (strcmp(tline(1:4), 'READ') || strcmp(tline(1:5), 'WRITE'))
        disp(tline);
        nums = sscanf(tline, '%s %f %f %f %f');
        nums = nums(end-3: end);
        if nums(1) == 0
            nums =[nan;nan;nan;nan];
        end
        
        [a, r] = strtok(tline);
        if strcmp(a, 'READ')
            mix_read = [mix_read nums];
        end
        if strcmp(a, 'WRITE')
            mix_write = [mix_write nums];
        end

    end
    tline = fgetl(fid);
end

fclose(fid);

save('data2.mat', 'mix_read', 'mix_write');