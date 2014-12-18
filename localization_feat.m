function[loc]=localization_feat(matrix)
    if issparse(matrix)==1
        loc_feat=full(matrix);
    else 
        loc_feat=matrix;
    end
    loc=zeros(size(loc_feat));
    for i=1:size(loc_feat,1)
        for j=i+1:size(loc_feat,1)
            loc(i,j)=loc_feat(i,:)*loc_feat(j,:)';% inner product of each node, measure for localization
            loc(j,i)=loc(i,j);
        end
    end
end

       
            
        