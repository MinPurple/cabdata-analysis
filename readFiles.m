%读取数据文件
function cab_dataset = readFiles(file_path)
%namelist  = dir('\cabspottingdata\new*.txt');
namelist  = dir(file_path);
length_of_file = length(namelist);
cab_dataset = cell(1,length_of_file); %定义一个1*l的元胞数组,存储所有的文件
for i = 1:length_of_file
    cab_dataset{1,i} = load(namelist(i).name);
end