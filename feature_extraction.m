function[cn, SI, JI, PAI, RAI, KI]=feature_extraction(ppinteraction,prunique)


    for i=1:length(ppinteraction)
        for j=1:length(ppinteraction)
            if ppinteraction(i,j)==-1;
                ppinteraction(i,j)=0;
            end
        end
    end

    

    id=prunique;
    bg=biograph(ppinteraction,id);
    degree_of_node=sum(ppinteraction)';% does it avoid self loops???

    
    for i=1:(length(ppinteraction))
        neighbor=getrelatives(bg.nodes(i));
        for j=1:length(neighbor)
            elmn{i,j}=neighbor(j).ID;
        end
    end
   
    U=zeros(size(ppinteraction));
    CN=cell(size(ppinteraction));
    for i=1:length(elmn)
        for j=i:length(elmn)
            x=elmn(i,:);
            x=x(~cellfun('isempty',x));
            y=elmn(j,:);
            y=y(~cellfun('isempty',y));
            CN{i,j}=intersect(x,y);
            CN{j,i}=CN{i,j};
            U(i,j)=length(union(x,y));
            U(j,i)=U(i,j);
        end
    end
    clear x y
    
    [SI, JI, PAI,cn]=deal(zeros(size(CN)));
    for i=1:length(CN)
        for j=i:length(CN)
            cn(i,j)=length(CN{i,j});
            cn(j,i)=cn(i,j);
            SI(i,j)=length(CN{i,j})/sqrt(degree_of_node(i)*degree_of_node(j));
            SI(j,i)=SI(i,j);
            JI(i,j)=length(CN{i,j})/U(i,j);
            JI(j,i)=JI(i,j);
            PAI(i,j)=degree_of_node(i)*degree_of_node(j);
            PAI(j,i)=PAI(i,j);
        end
    end
    
    RAI=zeros(size(CN));
    for i=1:length(CN)
        for j=i:length(CN)
            %if isempty(CN{i,j})==0
            x=(CN{i,j});
            y=find(ismember(id,x));
            RAI(i,j)=sum(1./degree_of_node(y));
            RAI(j,i)=RAI(i,j);
            %end
        end
    end
    clear x y
   
    I=eye(size(ppinteraction));
    lambda=eig(ppinteraction);
    rbeta=1/max(lambda);
    beta=rbeta-0.02;
    m=I-beta*ppinteraction;
    Katz=inv(m)-I;

    

    cn=cn - diag(diag(cn));
    SI=SI - diag(diag(SI));
    JI=JI - diag(diag(JI));
    PAI=PAI - diag(diag(PAI));
    RAI=RAI - diag(diag(RAI));
    KI=Katz - diag(diag(Katz));
    
end
    