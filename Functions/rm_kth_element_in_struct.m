function mystruct = rm_kth_element_in_struct(mystruct,k)
fn = fieldnames(mystruct);
for n=1:numel(fn)
    mystruct.(fn{n})(k)=[];
end