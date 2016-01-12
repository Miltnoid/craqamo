strong_read =  [];
strong_write = [];
ec_read = [];
ec_write = [];


fid = fopen('data.txt');

tline = fgetl(fid);
while ischar(tline)
    if length(tline) > 8 && (strcmp(tline(1:6), 'strong') || strcmp(tline(1:8), 'eventual'))
        disp(tline);
        nums = sscanf(tline, '%s %s %f %f %f %f');
        nums = nums(end-3: end);
        if nums(1) == 0
            nums =[nan;nan;nan;nan];
        end
        
        [a, r] = strtok(tline);
        b = strtok(r);
        if strcmp(a, 'strong') && strcmp(b, 'read')
            strong_read = [strong_read nums];
        end
        if strcmp(a, 'strong') && strcmp(b, 'write')
            strong_write = [strong_write nums];
        end
        if strcmp(a, 'eventual') && strcmp(b, 'read')
            ec_read = [ec_read nums];
        end
        if strcmp(a, 'eventual') && strcmp(b, 'write')
            ec_write = [ec_write nums];
        end

    end
    tline = fgetl(fid);
end

fclose(fid);

save('data.mat', 'strong_read', 'strong_write', 'ec_read', 'ec_write');