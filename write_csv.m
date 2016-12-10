function [ output_args ] = write_csv( fname, header, data )
%WRITE_CSV Summary of this function goes here
%   Detailed explanation goes here

%open file
fid = fopen(fname,'w');

%write header
for i = 1:numel(header)
fprintf(fid,'%s,',header{i});
end
fprintf(fid,'\n');

%write data
flag = 1;
count = 1;
ncols = numel(data);
while flag
    no_dat = 0;
    for i = 1:ncols
       temp = data{i};       
       switch count <= numel(temp)
           case 1
               fprintf(fid,'%e,',temp(count));
           case 0
               fprintf(fid,',');
               no_dat = no_dat + 1;
       end                
    end
    fprintf(fid,'\n');%new row
    
    if no_dat == ncols
        flag = 0;
    end
    count = count + 1;
end

fclose(fid);
end

