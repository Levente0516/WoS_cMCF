function [V,F] = read_obj_file(fname)

V = [];
F = [];

fid = fopen(fname,"r");

while true
    l = fgetl(fid);
    if ~ischar(l)
        break;
    end

    if startsWith(l, 'v ')
        V(end+1,:) = sscanf(l(3:end), '%f')';
    elseif startsWith(l,'f ')
        tok = strsplit(strtrim(l(3:end)));
        idx = cellfun(@(t) str2double(strtok(t,'/')), tok);
        F(end+1,:) = idx(1:3);
    end
end

fclose(fid);

end